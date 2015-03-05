Rails.application.config.middleware.use OmniAuth::Builder do
  secrets = Rails.application.secrets
  provider :twitter, ENV['TWITTER_APP_ID'], ENV['TWITTER_SECRET_KEY']
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET_KEY']
  provider :vkontakte, ENV['VKONTAKTE_APP_ID'], ENV['VKONTAKTE_SECRET_KEY']
  provider :identity, on_failed_registration: lambda { |env|
    IdentitiesController.action(:new).call(env)
  }

  OmniAuth.config.on_failure = Proc.new { |env|
    OmniAuth::FailureEndpoint.new(env).redirect_to_failure
  }

end