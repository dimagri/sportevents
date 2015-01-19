Rails.application.config.middleware.use OmniAuth::Builder do
  # TODO - change website and callback URL to production URL's in twitter dev center
  provider :twitter, 'cEDcqhwMRltJAsAfQn8NrDL29', '0Yc9dQDDaYfOB9fWN9MreQHzWn5c6qwIshNDd540QACctL9Fps'
end