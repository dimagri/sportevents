module CommentsHelper
  def format_date(date)
    if date.to_date == Date.today
      date.strftime("%H:%M")
    elsif date.to_date == Date.yesterday
      date.strftime("Вчера, %H:%M")
    else
      date.strftime("%H:%M %m.%d")
    end
  end
end
