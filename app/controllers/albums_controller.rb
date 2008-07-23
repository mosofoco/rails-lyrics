class AlbumsController < ApplicationController
  make_resourceful do
    actions :all
  end
  
  def current_objects
    if params[:letter]
      @current_objects = Album.alphabet(params[:letter]).paginate :page => params[:page], :include => :artist
    else
      @current_objects = Album.paginate( :page => params[:page], :order => "title ASC", :include => [:artist])
    end
  end
end
