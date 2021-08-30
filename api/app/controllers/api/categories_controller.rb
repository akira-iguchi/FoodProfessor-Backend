class Api::CategoriesController < ApplicationController
  def recipes
    @recipes = Recipe.includes(:categories).where(categories: {category_name: params[:category_name] }).order(id: :desc)
    render json: {
      recipes: @recipes,
    }, status: :ok
  end
end
