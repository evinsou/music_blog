class Disk < ActiveRecord::Base
   attr_accessible :title, :body, :year, :album_cover

  validates :title, :body, :year, :album_cover, presence: true
  validates :title, :body, :album_cover,  :format => { :with => /\A[a-zA-Z]+\z/,
    :message => "Only letters allowed" }
end
