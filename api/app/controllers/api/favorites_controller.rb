class Api::FavoritesController < ApplicationController
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @current_user = User.find(params[:current_user_id])
    @current_user.favorite(@recipe)
    render json: {}, status: :ok
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @current_user = User.find(params[:current_user_id])
    @current_user.unfavorite(@recipe)
    render json: {}, status: :ok
  end
end
