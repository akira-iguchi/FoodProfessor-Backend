Rails.application.routes.draw do
  namespace :api do
    resources :top, only: [:index]

    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      registrations: 'api/auth/registrations',
    }

    namespace :auth do
      resources :sessions, only: [:index]
    end

    resources :users, only: [:show, :edit, :update] do
      resources :comments, only: [:create, :destroy]
    end

    resources :follows, only: [:follow, :unfollow]

    resources :recipes, only: [:create, :edit, :update, :destroy]

    get '/ingredients/:ingredient_name/recipes', to: 'ingredients#recipes'

    get '/categories/:category_name/recipes', to: 'categories#recipes'

    get '/recipes/search/:recipe_name', to: 'recipes#search'

  end
end
