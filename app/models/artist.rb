class Artist < ActiveRecord::Base
  has_many :albums
  has_many :lyrics
  
  named_scope :alphabet, lambda { |letter| { :conditions => [" name like ?", "#{letter}%"] } }
end
