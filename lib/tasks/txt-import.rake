require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")
require 'xml/libxml'
require 'xml/xslt'
require 'hpricot'
require 'open-uri'

# XML Attribute macro
def xattr(xml,attribute)
  xml.find(attribute).first.child.to_s
end

namespace :import do
  task :xslt do
    xslt = XML::XSLT.new()
    xslt.xml = "db/xml/shane.xml"
    xslt.xsl = "db/xslt/itunes3.xsl"
    xslt.save("db/output/shane.xml")
  end
  
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
  
  task :widget do
    if File.exist? "#{ENV['HOME']}/Documents/Sing\ that\ iTune!"
      sh "rsync -avP #{ENV['HOME']}/Documents/Sing\\ that\\ iTune\\!/ db/txt/"
    end
  end
  
  task :txt => :widget do
    txts = Dir['db/txt/*/*.txt']

    for file in txts
      artist = file.split("/")[-2]
      title = file.split("/")[-1]
      title = title[0, title.length - 4]
      
      song = Lyric.find_or_initialize_by_title_and_artist(artist,title)
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

namespace :scrape do
  task :plyrics do
    if ENV['ARTIST'] and ENV['TITLE']
      song = Lyric.find_by_artist_and_title(ENV['ARTIST'], ENV['TITLE'])
      art = ENV['ARTIST'].downcase.gsub(/[^a-zA-Z0-9]/,"")
      tit = ENV['TITLE'].downcase.gsub(/[^a-zA-Z0-9]/,"")
      #doc = Hpricot(open("http://www.plyrics.com/lyrics/#{art}/#{tit}.html"))
      url = "http://www.plyrics.com/lyrics/#{art}/#{tit}.html"
    elsif ENV['ID']
      song = Lyric.find(ENV['ID'])
      art = song.artist.downcase.gsub(/[^a-zA-Z0-9]/,"")
      tit = song.title.downcase.gsub(/[^a-zA-Z0-9]/,"")
      url = "http://www.plyrics.com/lyrics/#{art}/#{tit}.html"
    else
      #doc = Hpricot(open("http://www.plyrics.com/lyrics/muchthesame/wish.html"))
      url = "http://www.plyrics.com/lyrics/muchthesame/wish.html"
    end
    puts "Opening [#{url}]..."
    doc = Hpricot(open(url)) || nil
    body = (doc/"div.body_lyr")
    for tag in %w(h1 h2 h3 h4 h5 div)
      (body/tag).remove
    end
    lines = body.to_s.split("\r\n")
    for line in lines
      # Replace all variety of HTML breaks with newlines
      line.gsub!(/<br[ ]?[\/]?>/,"\n")
    end
    body2 = lines.join()
    puts body2
    if song and body2
      song.body = body2
      song.save
    end
  end
end