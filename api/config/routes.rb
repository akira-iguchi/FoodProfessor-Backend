Rails.application.routes.draw do
  namespace :api do
    root 'top#index'

    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      registrations: 'api/auth/registrations',
      passwords: 'api/auth/passwords'
    }

    resources :users, only: [:show] do
      resources :folders, only: %i[create update destroy]
      resources :comments, only: %i[create destroy]
    end

    resources :follows, only: %i[create destroy]

  end
end
