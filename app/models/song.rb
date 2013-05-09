# encoding: UTF-8
class Song < ActiveRecord::Base
  attr_accessible :title, :authors, :record_year, :lyrics, :music_papers, :record_url

  serialize :music_papers
  validates :title, :authors, :lyrics,
            presence: true,
            :format => { :with => /[a-zA-ZА-Яа-я\s\d\(\)\.,!\?:\-\/\"]+/,
              :message => "Можно вводить только буквы и знаки препинания" }
end
