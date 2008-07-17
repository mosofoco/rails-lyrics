class AlbumsController < ApplicationController
  make_resourceful do
    actions :all
  end
  
  def current_objects
    @current_objects = Album.paginate :page => params[:page], :order => "title ASC"
  end
end
