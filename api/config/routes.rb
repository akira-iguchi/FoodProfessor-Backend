Rails.application.routes.draw do
  namespace :api do
    resources :top, only: %i[index]

    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      registrations: 'api/auth/registrations',
      passwords: 'api/auth/passwords'
    }

    namespace :auth do
      resources :sessions, only: %i[index]
    end

    resources :users, only: %i[show] do
      resources :comments, only: %i[create destroy]
      member do
        get :followings
        get :followers
      end
    end

    resources :follows, only: %i[follow unfollow]

    resources :recipes, only: [:show]

  end
end
