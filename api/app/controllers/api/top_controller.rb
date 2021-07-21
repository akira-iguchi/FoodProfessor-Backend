class Api::TopController < ApplicationController
  def index
    @recent_recipes = Recipe.all.order(id: :desc)
    @fastest_recipes =   # レシピを調理時間が短い順に取得
    @most_used_ingredients =   # 食材をよく使われる順に取得
    @ingredients = Ingredient.all
    @cooking_times = Recipe.select('recipe_time').order(:recipe_time)  # 調理時間を短い順に取得
    render json: {
      recent_recipes: @recent_recipes,
      fastest_recipes: @fastest_recipes,
      most_used_ingredients: @most_used_ingredients,
      ingredients: @ingredients,
      cooking_times: @cooking_times,
    }, status: :ok
  end
end
