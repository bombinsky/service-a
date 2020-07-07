class SessionsController < ApplicationController
  before_action :authenticate_user, except: [:new, :create]

  def new
  end

  def create
    session[:user_id] = User.find_or_create_with_twitter_auth_hash(auth_hash).id

    redirect_to root_path
  end

  def destroy
    session.delete(:user_id) if current_user

    redirect_to root_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end