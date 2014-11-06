module ApplicationHelper

  def fix_url(str)
    str.starts_with?('http://') ? str : "http://#{str}" 
  end

  def datetime(dt)
    if dt > Time.now.beginning_of_day
      "#{time_ago_in_words(dt)} ago"
    elsif logged_in? && !current_user.time_zone.blank?
      dt = dt.in_time_zone(current_user.time_zone)
      dt.strftime("%d %b. %Y at %H:%M %Z")
    else
      dt.strftime("%d %b. %Y at %H:%M %Z")
    end
  end

end
