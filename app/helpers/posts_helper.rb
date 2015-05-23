module PostsHelper
  def format_url(post)
    post.url.starts_with?("http") ? post.url : "http://#{post.url}" 
  end

  def user_friendly_date(post)
    difference = Time.zone.now - post.created_at
    distance_of_time_in_words(difference)
  end
end