class Album < ActiveRecord::Base
  belongs_to :artist
  has_many :lyrics
  
  named_scope :alphabet, lambda { |letter| { :conditions => ["title like ?", "#{letter}%"], :order => 'title ASC' } }
  named_scope :by_year, lambda { |year| { :conditions => ["year EQUAL ?", year], :order => 'title ASC' } }
end
