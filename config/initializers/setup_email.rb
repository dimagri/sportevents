ActionMailer::Base.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => "gmail.com",
    :user_name            => "sportevents.ck@gmail.com",
    :password             => "qsKXkQ8iFj",
    :authentication       => "plain",
    :enable_starttls_auto => true
}