class UserMailer < ApplicationMailer
  def email_confirmation(email, code)
    @code, @email = code, email
    subject = "Подтверджение электронной почты на Sportevents CK"
    mail(to: email, subject: subject)
  end
end
