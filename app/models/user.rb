class User < ActiveRecord::Base

  has_secure_password
  attr_accessible :email, :password, :password_confirmation

  validates :password, presence: true, on: :create

  validate :email, :format => {:with => /^[^@][\w.-]+@[\w.]+[.][a-z]{2,4}$/i }
end
