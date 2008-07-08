class LyricsController < ApplicationController
  make_resourceful do
    actions :all
  end

  def show
    @safe_artist = current_object.artist.downcase.gsub(/[^a-zA-Z0-9]/,"")
    @safe_title = current_object.title.downcase.gsub(/[^a-zA-Z0-9]/,"")
  end

  def current_objects
    @current_objects ||= Lyric.paginate :page => params[:page], :order => "artist ASC, album ASC, track ASC, title ASC"
  end
  
  def blank
    @current_objects = Lyric.blank.paginate :page => params[:page], :order => "artist ASC, album ASC, track ASC, title ASC"
    render :action => 'index'
  end
  
  def scrape
    @current_object = Lyric.find(params[:id])
    if params[:source] == 'plyrics'
      @current_object.scrape_plyrics
      redirect_to :action => 'show', :id => @current_object.id
    end
  end
  
  def search
    @search = Ultrasphinx::Search.new(:query => params[:query])
    @search.run
    @current_objects = @search.results
    flash[:message] = "#{@current_objects.size} Results"
    #render :action => 'index'
  end
  
end
