module ApplicationHelper
  def fix_url(url)
    url.starts_with?("http://") ? url : "http://#{url}" 
  end

  def user_friendly_date(datetime)
    difference = Time.zone.now - datetime
    distance_of_time_in_words(difference)
  end
end
