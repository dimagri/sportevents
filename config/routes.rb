Rails.application.routes.draw do

  Rails.application.routes.default_url_options[:host] = 'localhost:3000' # for development

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'home#index'
  get 'home/index'

  resources :users do
    post 'send_email_confirmation' => 'users#send_email_confirmation'
  end

  resources :clubs do
    resources :comments
  end

  resources :events do
    resources :comments
  end

  resources :friendships

  # Messages
  resources :messages, only: [:new, :create, :show]
  get 'inbox' => 'messages#inbox'
  get 'sentbox' => 'messages#sentbox'

  # Authorization
  get '/auth/:provider/callback' => 'sessions#create'
  post '/auth/:provider/callback' => 'sessions#create'
  get 'logout' => 'sessions#destroy'
  get '/auth/failure' => 'sessions#failure'
  resources :identities
  get 'confirm_email' => 'users#confirm_email', as: 'confirm_email'

  # Locations
  post '/get_location' => 'locations#get_location'


end
