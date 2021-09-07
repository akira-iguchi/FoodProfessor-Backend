class Api::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes.order(id: :desc)
    @favorite_recipes = @user.favorite_recipes.order(id: :desc)
    render json: {
      user: @user,
      recipes: @recipes,
      favorite_recipes: @favorite_recipes,
    }, status: :ok
  end

  def edit
    @user = User.find(params[:id])
    render json: {
      user: @user,
    }, status: :ok
  end
end
