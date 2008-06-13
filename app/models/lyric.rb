class Lyric < ActiveRecord::Base
  is_indexed :fields => ['artist','album','title','body']
end
