Rails.application.config.middleware.use OmniAuth::Builder do
  # TODO - change website and callback URL to production URL's in twitter dev center
  # TODO - hide ids and secret keys
  secrets = Rails.application.secrets
  provider :twitter, secrets.twitter_app_id, secrets.twitter_secret_key
  provider :facebook, secrets.facebook_app_id, secrets.facebook_secret_key
  provider :vkontakte, secrets.vkontakte_app_id, secrets.vkontakte_secret_key
end