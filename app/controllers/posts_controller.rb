class PostsController < ApplicationController
  before_action :obtain_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:show, :index]
  before_action :require_creator, only: [:edit, :update]



  def index
    displace = params[:offset]  ? params[:offset] : "1"
    number_of_posts = Post.all.size
    @posts = Post.limit(Post::PER_PAGE ).offset(Post::PER_PAGE * (displace.to_i - 1))
    @pages = number_of_posts / Post::PER_PAGE
    @pages += 1 if number_of_posts.odd?

    respond_to do |format|
      format.html
      format.js { expires_now if Rails.env.development? || Rails.env.test? }
    end
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
      flash[:notice] = "Your post has been updated."
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def vote
    vote = Vote.create(voteable: @post,
                       creator: current_user, vote: params[:vote])
    if vote.valid?
     flash[:notice] = "Your vote was counted."
    else
     flash[:error] = "You can only vote on a post once."
    end
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  private

  def require_creator
    unless logged_in? and (current_user == @post.creator || current_user.is_admin?)
      access_denied
    end
  end

  def obtain_post
    @post = Post.find_by_slug params[:id]
  end

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end
end
