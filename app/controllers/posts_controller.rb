class PostsController < ApplicationController
  before_action :obtain_post, only: [:show,:edit,:update]
  
  def index
    @posts = Post.all
  end

  def show; end

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
      render 'posts/new'
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:notice] = "Your post has been updated."
      redirect_to post_path(@post)
    else
      render '/edit'
    end
  end

  private 

  def obtain_post
    @post = Post.find(params[:id])
  end 

  def post_params
    params.require(:post).permit(:title, :url, :description)
  end

end
