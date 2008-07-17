class ArtistsController < ApplicationController
  make_resourceful do
    actions :all
  end
  
  def current_objects
    @current_objects = Artist.paginate :page => params[:page], :order => "name ASC"
  end
  
end
