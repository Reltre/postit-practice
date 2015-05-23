class CategoriesController < ApplicationController
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

  def edit
  end

  def show
    @category = Category.find(params[:id])
  end

  def update
  end

  def destroy 

  end

  def add_category
    @category = Category.new(category_params)
    @post = Post.find(params[:post_id])
    post_category = PostCategory.new(category_id: @category.id, 
                                     post_id: @post.id)
    @category.post_categories << post_category
    @post.post_categories << post_category

    unless @category.save
      render '/new'
    end
    
    redirect_to post_path(@post)
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end