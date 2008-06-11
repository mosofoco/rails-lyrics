class LyricsController < ApplicationController
  make_resourceful do
    actions :all
  end
  
  def current_objects
    @current_objects ||= Lyric.find(:all, :order => "artist ASC, title ASC", :limit => 30)
  end
end
