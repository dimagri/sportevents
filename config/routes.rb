Rails.application.routes.draw do

  root 'home#index'

  get 'home/index'

  # Authorization
  get '/auth/:provider/callback' => 'sessions#create'
  post '/auth/:provider/callback' => 'sessions#create'
  get 'logout' => 'sessions#destroy'
  get '/auth/failure' => 'sessions#failure'
  resources :identities
end
