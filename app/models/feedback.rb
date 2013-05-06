# encoding: UTF-8
class Feedback < ActiveRecord::Base
 attr_accessible :name, :location, :body, :created_at, :check_code, :published
   attr_accessor :check_code

  validates :name, :location, :body, :presence => true,
                                    :format => {:with => /[a-zA-Z\sА-Яа-я\d\(\)\.\,\!\?:-@]+/,
                                                :message => "Можно вводить только буквы и знаки препинания" }
  validates :check_code, presence: true, :on => :create
  validate :check_code_is_not_current_year, :on => :create

  scope :published, where( :published => true )
  scope :not_published, where( :published => false )
  def publish
    self.published = true
  end
private
  def check_code_is_not_current_year
    unless check_code.to_s == Date.today.strftime("%Y") # to_s need to be?
      errors.add(:check_code, '- это не текущий год')
    end
  end

end
