class WelcomeController < ApplicationController
  #before_filter :authenticate
  def index
    @feedbacks = Feedback.order('created_at DESC')
    @messages = Message.order('created_at DESC')
  end
end
