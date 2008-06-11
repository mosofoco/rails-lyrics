require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")
require 'xml/libxml'
require 'xml/xslt'

namespace :import do
  task :xslt do
    xslt = XML::XSLT.new()
    xslt.xml = "db/xml/sample.xml"
    xslt.xsl = "db/xslt/itunes3.xsl"
    xslt.save("db/output/sample.xml")
  end
  
  task :xml do
    xslt = XML::XSLT.new()
    xslt.xml = "db/xml/sample.xml"
    xslt.xsl = "db/xslt/itunes3.xsl"
    xml = xslt.serve()
    
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