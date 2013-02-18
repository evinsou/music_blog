# encoding: UTF-8
class Disk < ActiveRecord::Base
   attr_accessible :title, :body, :year, :album_cover

  validates :title, :body, :year, :album_cover, presence: true
  validates :title, :body, :album_cover,  :format => { :with => /\A[a-zA-Z\sА-Яа-я\.\,\!\?-]+\z/,
    :message => "Можно вводить только буквы и знаки препинания" }
end
