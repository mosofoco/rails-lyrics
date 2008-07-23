class ArtistsController < ApplicationController
  make_resourceful do
    actions :all
  end
  
  def current_objects
    if params[:letter]
      @current_objects = Artist.alphabet(params[:letter]).paginate :page => params[:page], :order => "name ASC"
    else
      @current_objects = Artist.paginate :page => params[:page], :order => "name ASC"
    end
  end
  
end
