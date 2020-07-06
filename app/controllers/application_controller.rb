class ApplicationController < ActionController::Base

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  protected

  def authenticate_user
    redirect_to new_session_path unless current_user
  end
end
