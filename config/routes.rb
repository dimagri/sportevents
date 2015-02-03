Rails.application.routes.draw do

  Rails.application.routes.default_url_options[:host] = 'localhost:3000' # for development

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'home#index'
  get 'home/index'

  resources :users do
    resources :messages
  end

  resources :clubs do
    resources :comments
  end

  resources :events do
    resources :comments
  end

  resources :friendships

  # Authorization
  get '/auth/:provider/callback' => 'sessions#create'
  post '/auth/:provider/callback' => 'sessions#create'
  get 'logout' => 'sessions#destroy'
  get '/auth/failure' => 'sessions#failure'
  resources :identities
  get 'confirm_email' => 'users#confirm_email', as: 'confirm_email'

  post '/get_location' => 'locations#get_location'
end
