Rails.application.config.middleware.use OmniAuth::Builder do
  # TODO - change website and callback URL to production URL's in twitter dev center
  # TODO - hide ids and secret keys
  provider :twitter, 'cEDcqhwMRltJAsAfQn8NrDL29', '0Yc9dQDDaYfOB9fWN9MreQHzWn5c6qwIshNDd540QACctL9Fps'
  provider :facebook, '404934306332466', '0d978446ad82c77fd8785f04143f8a6a'
end