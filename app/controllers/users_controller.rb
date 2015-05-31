class UsersController < ApplicationController
  def new
  #@user = User.new
  end

  def create
    user = User.new(username: params[:username], password: params[:password])
    if user.save
      flash[:notice] = "You're now registered."
      redirect_to root_path
    else
      flash[:error] = "You're username or password was not valid."
      redirect_to register_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end