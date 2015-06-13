class PostsController < ApplicationController
  before_action :obtain_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except:[:show, :index, :vote] 
  before_action :require_same_user, only:[:edit, :update]

  def index
    @posts = Post.all.sort_by {|post| post.total_votes}.reverse
  end

  def show
    @comment = Comment.new  
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user
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
      #binding.pry
      flash[:notice] = "Your post has been updated."
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def vote
    if current_user.nil?
      flash[:error] = "You need to be logged in to vote"
    else
      vote = Vote.create(voteable: @post, creator: current_user, vote: params[:vote])
      if vote.valid?
        flash[:notice] = "Your vote was counted."
      else
        flash[:error] = "You can only vote on a post once."
      end
    end
    redirect_to :back
  end

  private 

  def require_same_user
    if current_user != @post.creator
      flash[:error] = "You do not have authorization to do that."
      redirect_to :back
    end
  end

  def obtain_post
    @post = Post.find(params[:id])
  end 

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end
end
