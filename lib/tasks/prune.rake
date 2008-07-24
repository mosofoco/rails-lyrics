namespace :prune do
  task :songs do
    for song in Lyric.all
      if song.body.nil? or song.body.empty?
        song.destroy
      end
    end
  end
  
  task :albums do
    for album in Album.all
      if album.lyrics.empty?
        album.destroy
      end
    end
  end
  
  task :artists do
    for artist in Artist.all
      if artist.lyrics.empty? && artist.albums.empty?
        artist.destroy
      end
    end
  end
end