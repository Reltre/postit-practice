class PostsController < ApplicationController
  before_action :obtain_post, only: [:show,:edit,:update]
  
  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new  
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = User.first
    if @post.save
      flash[:notice] = "Your post has been saved."
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      binding.pry
      flash[:notice] = "Your post has been updated."
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  private 

  def obtain_post
    @post = Post.find(params[:id])
  end 

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end
end
