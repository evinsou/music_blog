class TitovSong < ActiveRecord::Base
  attr_accessible :title, :song_length, :authors, :url_to_mp3
  validates :title, :authors, :url_to_mp3, :presence => true
end