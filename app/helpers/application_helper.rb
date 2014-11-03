module ApplicationHelper

  def fix_url(str)
    str.starts_with?('http://') ? str : "http://#{str}" 
  end

  def datetime(dt)
    dt.strftime("%d %b. %Y at %H:%M %Z")
  end

end
