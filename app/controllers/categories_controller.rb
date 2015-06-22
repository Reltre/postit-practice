class CategoriesController < ApplicationController
  before_action :require_user, only: [:new, :create]

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category has been created."
      redirect_to root_path
    else
      render 'categories/new'
    end
  end

  def new
    @category = Category.new
  end

  def edit; end

  def show
    @category = Category.find_by_slug(params[:id])
  end

  def update; end

  def destroy; end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
