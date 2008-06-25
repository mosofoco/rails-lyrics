class Lyric < ActiveRecord::Base
  is_indexed :fields => ['artist','album','title','body']
  
  named_scope :blank, :conditions => { :body => nil }
end
