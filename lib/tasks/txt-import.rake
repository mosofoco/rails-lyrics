require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")
require 'open-uri'

# XML Attribute macro
def xattr(xml,attribute)
  xml.find(attribute).first.child.to_s
end

namespace :import do
  desc "Translate a raw iTunes XML into a more concise (and much smaller) format"
  task :xslt do
    xslt = XML::XSLT.new()
    xslt.xml = "db/xml/shane.xml"
    xslt.xsl = "db/xslt/itunes3.xsl"
    xslt.save("db/output/shane.xml")
  end
  
  desc "Populate the database with entries from an iTunes XML library"
  task :xml do
    FILES = %w(shane.xml)
    VALID_GENRES = ["rock", "metal", "punk", "punk rock"]
    for file in FILES
      doc = XML::Document.file("#{RAILS_ROOT}/db/output/#{file}")
      tracks = doc.find('//library/track')
      for track in tracks
        title = xattr(track,'title')
        artist = xattr(track,'artist')
        album = xattr(track,'album')
        year = xattr(track,'year')
        genre = xattr(track,'genre')
        track = xattr(track,'track_number')
        
        if !VALID_GENRES.include? genre.downcase
          next
        end

        song = Lyric.find_or_initialize_by_title_and_artist_and_album(title,artist,album)
        song.year = year
        song.genre = genre
        song.track = track
        
        puts "New song: #{title} by #{artist}" if song.id.nil?
        
        song.save

      end
    end
  end
  
  desc "Gather txt lyrics from SingThatiTune widget"
  task :widget do
    if File.exist? "#{ENV['HOME']}/Documents/Sing\ that\ iTune!"
      sh "rsync -avP #{ENV['HOME']}/Documents/Sing\\ that\\ iTune\\!/ db/txt/"
    end
  end
  
  desc "Parse widget txt files for lyrics"
  task :txt do
    txts = Dir['db/txt/*/*.txt']

    for file in txts
      artist = file.split("/")[-2]
      title = file.split("/")[-1]
      title = title[0, title.length - 4]
      
      song = Lyric.find_or_initialize_by_artist_and_title(artist,title)
      if song.body.nil? || song.body.empty?
        f = File.new(file)
        5.times { f.gets }
        song.body = ""
        newbody = f.readlines
        for line in newbody
          line = line.split("\r").join("\n")
          song.body += line
        end
        #song.body.gsub!("\n","<br>")
        puts "Lyrics added to #{song.title} by #{song.artist}"
        song.save
      end
    end
  end
end