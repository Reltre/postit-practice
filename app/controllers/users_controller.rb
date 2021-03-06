class UsersController < ApplicationController
  before_action :obtain_user, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in_user(@user, "You're now registered.")
    else
      render :new
    end
  end

  def edit; end

  def show; end

  def update
    binding.pry
    if @user.update(user_params)
      flash[:notice] = "Your profile has been updated."
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def require_same_user
    if current_user != @user
      flash[:error] = "You do not have authorization to do that."
      redirect_to root_path
    end
  end

  def obtain_user
    @user =  User.find_by_slug(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :password, :time_zone, :phone)
  end
end
