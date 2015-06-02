class CommentsController < ApplicationController
  before_action :require_user

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(params.require(:comment).permit(:body))
    @comment.creator = current_user
    if @comment.save
      flash[:notice] = "You have created your comment successfully."
    else
      flash[:error] = "You cannot post an empty comment."
    end
    redirect_to post_path(@post)
  end
end