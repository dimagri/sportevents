Rails.application.routes.draw do

  root 'home#index'

  get 'home/index'

  # Authorization via facebook and twitter
  get '/auth/:provider/callback' => 'sessions#create'
  get 'signout' => 'sessions#destroy'
end
