Rails.application.routes.draw do

  get 'clubs/index'

  get 'clubs/new'

  get 'clubs/create'

  get 'clubs/edit'

  get 'clubs/update'

  root 'home#index'

  get 'home/index'

  resources :users, only: [ :show, :edit, :update ]
  resources :clubs

  # Authorization
  get '/auth/:provider/callback' => 'sessions#create'
  post '/auth/:provider/callback' => 'sessions#create'
  get 'logout' => 'sessions#destroy'
  get '/auth/failure' => 'sessions#failure'
  resources :identities

  post '/get_location' => 'home#get_location'
end
