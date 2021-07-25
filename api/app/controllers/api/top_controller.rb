class Api::TopController < ApplicationController
  def index
    @recent_recipes = Recipe.all.order(id: :desc)
    @fastest_recipes = Recipe.order(:recipe_time)  # レシピを調理時間が短い順に取得
    # @most_used_ingredients =   # 食材をよく使われる順に取得
    @ingredients = Ingredient.all
    render json: {
      recent_recipes: @recent_recipes,
      fastest_recipes: @fastest_recipes,
      # most_used_ingredients: @most_used_ingredients,
      ingredients: @ingredients,
    }, status: :ok
  end
end
