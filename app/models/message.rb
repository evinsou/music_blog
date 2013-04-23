# encoding: UTF-8
class Message < ActiveRecord::Base
  attr_accessible :name, :location, :email, :body

  validates :name, :location, :email, :body, presence: true
  validates :name, :location, :body,  :format => { :with => /\A[a-zA-ZА-Яа-я\s\d\.\,\!\?-]+\z/,
    :message => "Можно вводить только буквы и знаки препинания" }
  validates  :email, format: { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create }
  validates :name, :location, :length => { :maximum => 50 }
  validates :body, :length => { :maximum => 500 }
end
