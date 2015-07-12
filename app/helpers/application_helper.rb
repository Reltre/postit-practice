module ApplicationHelper


  def fix_url(url)
    url =~ /^https?:\/\//  ? url : "http://#{url}"
  end

  def user_friendly_date(datetime)
    if logged_in? && !current_user.time_zone.blank?
      Time.use_zone(current_user.time_zone) do
        distance_of_time_in_words_to_now(datetime)
      end
    else
      distance_of_time_in_words_to_now(datetime)
    end
  end
end
