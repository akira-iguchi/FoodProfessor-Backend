class Api::IngredientsController < ApplicationController
  def recipes
    @recipes = Recipe.includes(:ingredients).where(ingredients: {ingredient_name: params[:ingredient_name]}).order(id: :desc)
    render json: {
      recipes: @recipes,
    }, status: :ok
  end
end
