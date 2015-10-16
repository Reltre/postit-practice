class CommentsController < ApplicationController
  before_action :require_user


  def create
    binding.pry
    @post = Post.find_by_slug params[:post_id]
    @comment = @post.comments.new(params.require(:comment).permit(:body))
    @comment.creator = current_user
    if @comment.save
      flash[:notice] = "You have created your comment successfully."
    else
      flash[:error] = "You cannot post an empty comment."
    end
    redirect_to post_path(@post)
  end

  def vote
    @comment = Comment.find(params[:id])
    vote = Vote.create(voteable: @comment,
                       creator: current_user,
                       vote: params[:vote])
    if vote.valid?
     flash[:notice] = "Your vote was counted."
    else
     flash[:error] = "You can only vote on that comment once."
    end
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
end
