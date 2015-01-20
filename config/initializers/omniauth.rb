Rails.application.config.middleware.use OmniAuth::Builder do
  # TODO - change website and callback URL to production URL's in twitter dev center
  secrets = Rails.application.secrets
  provider :twitter, secrets.twitter_app_id, secrets.twitter_secret_key
  provider :facebook, secrets.facebook_app_id, secrets.facebook_secret_key
  provider :vkontakte, secrets.vkontakte_app_id, secrets.vkontakte_secret_key
  provider :identity, on_failed_registration: lambda { |env|
    IdentitiesController.action(:new).call(env)
  }

  OmniAuth.config.on_failure = Proc.new { |env|
    OmniAuth::FailureEndpoint.new(env).redirect_to_failure
  }

end