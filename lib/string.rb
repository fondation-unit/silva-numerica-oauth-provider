class String
  def patronize
    humanize.gsub(/\b('?[a-z])/) { Regexp.last_match(1).capitalize }
  end
end
