class UserMailer < ApplicationMailer
  def email_confirmation(user, email, code)
    @user, @code, @email = user, code, email
    subject = "Подтверджение электронной почты на Sportevents CK"
    mail(to: email, subject: subject)
  end

  def news_feed(email, unread_events)
    @unread_events = unread_events
  	subject = "Обновления на Sportevents"
  	mail(to: email, subject: subject)
  end
end
