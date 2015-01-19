Rails.application.routes.draw do

  root 'home#index'

  get 'home/index'

  get '/auth/twitter/callback' => 'sessions#create'
  get 'signout' => 'sessions#destroy'
end
