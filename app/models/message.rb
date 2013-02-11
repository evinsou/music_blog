class Message < ActiveRecord::Base
  attr_accessible :name, :location, :email, :body

  validates :name, :location, :email, :body, presence: true
  validates :name, :location, :body,  :format => { :with => /\A[a-zA-Z]+\z/,
    :message => "Only letters allowed" }
  #validates  :email, format: { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create }
  #validates  :email, format: { :with => /^[^@][\w.-]+@[\w.]+[.][a-z]{2,4}$/i, :on => :create }
  validates :name, :location, :length => { :maximum => 50 }
  validates :body, :length => { :maximum => 500 }
end
