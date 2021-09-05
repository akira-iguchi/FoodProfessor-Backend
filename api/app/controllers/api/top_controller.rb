class Api::TopController < ApplicationController
  def index
    @recent_recipes = Recipe.all.order(id: :desc)
    @fastest_recipes = Recipe.order(:recipe_time).limit(3)  # レシピを調理時間が短い順に取得
    @favorite_ranking_recipes = Recipe.find(Favorite.group(:recipe_id).order('count(recipe_id) desc').limit(3).pluck(:recipe_id))
    render json: {
      recent_recipes: @recent_recipes,
      fastest_recipes: @fastest_recipes,
      favorite_ranking_recipes: @favorite_ranking_recipes,
    }, status: :ok
  end
end
