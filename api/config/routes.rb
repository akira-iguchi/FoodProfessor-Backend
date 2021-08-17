Rails.application.routes.draw do
  namespace :api do
    resources :top, only: [:index]

    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      registrations: 'api/auth/registrations',
      passwords: 'api/auth/passwords'
    }

    namespace :auth do
      resources :sessions, only: [:index]
    end

    resources :users, only: [:show, :edit, :update] do
      resources :comments, only: [:create, :destroy]
    end

    resources :follows, only: [:follow, :unfollow]

    resources :recipes, only: [:show, :create, :edit, :update, :destroy]

  end
end
