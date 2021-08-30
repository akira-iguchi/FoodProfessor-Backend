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

  def update
    @user = User.find(params[:id])
    if @user.update(update_params)
        render json: {
            user: @user
        }, status: :created
    else
        render json: [
          @user.errors
        ], status: 422
    end
  end

  private

  def update_params
    params.permit(:email, :first_name, :last_name, :profile_image)
  end
end
