class Album < ActiveRecord::Base
  belongs_to :artist
  has_many :lyrics
  
  named_scope :alphabet, lambda { |letter| { :conditions => ["title like ?", "#{letter}%"], :order => 'title ASC' } }
end
