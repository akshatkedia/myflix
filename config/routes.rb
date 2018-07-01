Myflix::Application.routes.draw do
  root to: 'pages#front'

  namespace 'ui' do
    get '/', action: :index
    %w(account admin_add_video admin_views_payments advanced_search confirm_password_reset forgot_password front genre home invalid_token invite my_queue people plan_and_billing register reset_password sign_in user video).each do |action|
      get action, action: action
    end
  end

  get '/home', to: 'videos#index'
  resources :videos, only: [:show] do
    collection do
      get :search, to: 'videos#search'
    end

    resources :reviews, only: [:create]
  end

  namespace :admin do
    resources :videos, only: [:new, :create]
  end

  resources :categories, only: [:show]

  get 'my_queue', to: 'queue_items#index'
  post 'update_queue', to: 'queue_items#update_queue'
  resources :queue_items, only: [:create, :destroy]

  get 'register', to: 'users#new'
  get 'register/:token', to: 'users#new_with_invitation_token', as: 'register_with_token'
  resources :users, only: [:create, :show]

  get 'sign_in', to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'
  resources :sessions, only: [:create]

  get 'people', to: 'relationships#index'
  resources :relationships, only: [:create, :destroy]

  get 'forgot_password', to: 'forgot_passwords#new'
  get 'forgot_password_confirmation', to: 'forgot_passwords#confirm'
  resources :forgot_passwords, only: [:create]

  get 'expired_token', to: 'pages#expired_token'
  resources :password_resets, only: [:show, :create]

  resources :invitations, only: [:new, :create]

  mount StripeEvent::Engine, at: '/stripe_events'
end
