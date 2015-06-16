class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])  
      log_in_user(user)
      flash[:notice] = "Welcome #{user.username}"
      redirect_to root_path
    else
      flash.now[:error] = "You're username or password was not valid."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've logged out!"
    redirect_to :root
  end
end