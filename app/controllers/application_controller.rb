 # encoding: UTF-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
  protected
  def authenticate
    logged_in? ? true : access_denied
  end
  def logged_in?
    @current_user.is_a? User
  end
  def access_denied
    redirect_to log_in_path, notice: 'Чтобы зайти в личную часть блога, пожалуйста, залогинтесь.'
  end
end
