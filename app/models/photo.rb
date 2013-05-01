class Photo < ActiveRecord::Base
  attr_accessible :title, :image_url, :small_picture
  validates :image_url, :small_picture, :presence => true
end
