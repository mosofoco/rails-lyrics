require 'hpricot'
require 'open-uri'

class Lyric < ActiveRecord::Base
  define_index do
    indexes title, :sortable => true
    indexes body
    indexes artist.name, :as => :artist, :sortable => true
    indexes album.title, :as => :album, :sortable => true
    
    has artist_id, album_id
  end
  
  named_scope :blank, :conditions => { :body => nil }
  named_scope :alphabet, lambda { |letter| { :conditions => ['title like ?', "#{letter}%"], :order => 'title ASC' } }
  
  belongs_to :artist
  belongs_to :album
  
  def scrape_plyrics
    song = self
    art = song.artist.name.downcase.gsub(/[^a-zA-Z0-9]/,"")
    tit = song.title.downcase.gsub(/[^a-zA-Z0-9]/,"")
    url = "http://www.plyrics.com/lyrics/#{art}/#{tit}.html"
    doc = Hpricot(open(url))
    body = (doc/"div.body_lyr")
    for tag in %w(h1 h2 h3 h4 h5 div)
      (body/tag).remove
    end
    lines = body.to_s.gsub("’","\'").split("\r\n")
    for line in lines
      # Replace all variety of HTML breaks with newlines
      line.gsub!(/<br[ ]?[\/]?>/,"\n")
    end
    body2 = lines.join()
    if !body2.empty?
      self.body = body2
      self.save!
    end
  end
end
