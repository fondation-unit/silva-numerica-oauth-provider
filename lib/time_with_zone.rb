class ActiveSupport::TimeWithZone
  def date_readable
    strftime("%d/%m/%Y - %H:%m")
  end
end
