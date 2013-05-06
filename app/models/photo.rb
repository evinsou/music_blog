class Photo < ActiveRecord::Base
  attr_accessible :title, :image_url, :small_photo
  validates :image_url, :small_photo, :presence => true
end
