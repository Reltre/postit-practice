class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "You're now registered."
      log_in_user(@user)
    else
      render :new
    end
  end

  def edit
  end

  def show
  end

  def update
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end