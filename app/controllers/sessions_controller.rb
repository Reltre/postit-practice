class SessionsController < ApplicationController
  def new

  end

  def create
   @user = User.find_by(username: params[:username])
   if @user.authenticate(params[:password]) 
      session[:user_id] = @user.id
      flash[:notice] = "Welcome #{@user.username}"
      redirect_to root_path
    else
      flash[:error] = "You're username or password was not valid."
      redirect_to login_path
    end
  
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end