Rails.application.routes.draw do
  namespace :api do
    root 'top#index'

    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      registrations: 'api/auth/registrations',
      passwords: 'api/auth/passwords'
    }

    namespace :auth do
      resources :sessions, only: %i[index]
    end

    resources :users, only: %i[show followings followers] do
      resources :folders, only: %i[create update destroy]
      resources :comments, only: %i[create destroy]
    end

    resources :follows, only: %i[create destroy]

    resources :recipes, only: [:show]

  end
end
