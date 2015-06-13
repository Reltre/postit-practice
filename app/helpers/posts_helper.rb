module PostsHelper
  def is_same_user?
    current_user == @post.creator
  end
end
