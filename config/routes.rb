Rails.application.routes.draw do

  get 'messages/index'

  get 'messages/show'

  get 'messages/new'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'home#index'
  get 'home/index'

  resources :users, only: [ :show, :edit, :update ]

  resources :clubs do
    resources :comments
  end

  resources :events do
    resources :comments
  end

  # Authorization
  get '/auth/:provider/callback' => 'sessions#create'
  post '/auth/:provider/callback' => 'sessions#create'
  get 'logout' => 'sessions#destroy'
  get '/auth/failure' => 'sessions#failure'
  resources :identities

  post '/get_location' => 'locations#get_location'
end
