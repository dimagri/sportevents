Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'home#index'
  get 'home/index'

  resources :users, only: [ :show, :edit, :update ]
  resources :clubs, :events

  # Authorization
  get '/auth/:provider/callback' => 'sessions#create'
  post '/auth/:provider/callback' => 'sessions#create'
  get 'logout' => 'sessions#destroy'
  get '/auth/failure' => 'sessions#failure'
  resources :identities

  post '/get_location' => 'locations#get_location'
end
