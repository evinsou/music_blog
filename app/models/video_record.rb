class VideoRecord < ActiveRecord::Base

  attr_accessible :title, :youtube_url
  validates :title, :youtube_url, :presence => true

end
