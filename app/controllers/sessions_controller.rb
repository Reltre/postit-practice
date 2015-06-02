class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(username: params[:username])
    log_in_user(user)
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've logged out!"
    redirect_to :root
  end
end