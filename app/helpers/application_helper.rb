module ApplicationHelper

  def truncate(str, max_chars)
      if str.length > max_chars
        str[0..max_chars] + "..."
      else
        str
      end
  end

end
