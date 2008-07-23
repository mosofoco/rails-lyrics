class ArtistsController < ApplicationController
  make_resourceful do
    actions :all
  end
  
  def current_objects
    if params[:letter]
      @current_objects = Artist.alphabet(params[:letter]).paginate :page => params[:page]
    else
      @current_objects = Artist.paginate :page => params[:page], :order => "name ASC"
    end
  end
  
  def current_object
    @current_object = Artist.find(params[:id], :include => [:albums, :lyrics])
  end
  
end
