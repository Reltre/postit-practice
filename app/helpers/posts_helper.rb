module PostsHelper
  def is_same_user?(post)
    current_user == post.creator
  end
end
