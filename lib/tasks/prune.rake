namespace :prune do
  task :songs do
    for song in Lyric.all
      if song.body.nil? or song.body.empty?
        song.destroy
      end
    end
  end
end