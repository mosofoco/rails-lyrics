namespace :import do
  task :txt do
    txts = Dir['db/txt/*/*.txt']

    for file in txts
      artist = file.split("/")[-2]
      title = file.split("/")[-1]
      title = title[0, title.length - 4]
      puts "#{artist} - #{title}"
      
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
        puts "Lyrics added to #{song.title} by #{art.name}"
        song.save
      end
    end
  end
end