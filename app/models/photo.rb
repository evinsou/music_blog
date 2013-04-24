class Photo < ActiveRecord::Base
  attr_accessible :title, :url
  validates :title, :url, :presence => true
end
