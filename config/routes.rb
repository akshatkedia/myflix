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

  resources :categories

  get 'register', to: 'users#new'
  get 'sign_in', to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'

  resources :users, only: [:create]
  resources :sessions, only: [:create]
end
