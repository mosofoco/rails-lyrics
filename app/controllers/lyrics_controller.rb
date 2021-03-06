class LyricsController < ApplicationController
  make_resourceful do
    actions :all
  end

  def show
    @safe_artist = current_object.artist.name.downcase.gsub(/[^a-zA-Z0-9]/,"")
    @safe_title = current_object.title.downcase.gsub(/[^a-zA-Z0-9]/,"")
  end

  def current_objects
      @current_objects ||= Lyric.paginate :page => params[:page], :order => "title ASC", :include => [:artist]
  end
  
  def current_object
    @current_object ||= Lyric.find(params[:id], :include => [:artist, :album])
  end
  
  def blank
    @current_objects = Lyric.blank.paginate :page => params[:page], :order => "artist_id ASC, album_id ASC, track ASC, title ASC"
    render :action => 'index'
  end
  
  def index
    if params[:letter]
      @current_objects = Lyric.alphabet(params[:letter]).paginate( :page => params[:page], :include => [:artist] )
    else
      current_objects
    end
  end
  
  def scrape
    @current_object = Lyric.find(params[:id])
    if params[:source] == 'plyrics'
      @current_object.scrape_plyrics
      redirect_to :action => 'show', :id => @current_object.id
    end
  end
  
  def search
    @query = params[:query]
    @current_objects = Lyric.search(@query)
    flash[:message] = "#{@current_objects.size} Results"
    #render :action => 'index'
  end
  
  def tag
    @current_object = Lyric.find(params[:id])
    if params[:tags]
      @tag_list = @current_object.tag_list.join(", ") + params[:tags]
      @current_object.tag_list = @tag_list
      @current_object.save
      flash[:message] = "Tags saved."
      redirect_to lyric_path(@current_object)
    end
    
      
  end
  
  def tagged
    @current_objects = Lyric.find_tagged_with(params[:id])
  end
  
end
