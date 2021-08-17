# routes.rbでnamespaceを"api"に設定 -> Api::
class Api::RecipesController < ApplicationController
  before_action :authenticate_user, only: [:create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]

  def show
  end

  def create
    @recipe = current_api_user.recipes.build(recipe_params)
    # 作成成功の可否でjsonを変更
    if @recipe.save
        render json: {
            recipe: @recipe
        }, status: :created
    else
        render json: {}, status: :internal_server_error
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @recipe.destroy
    render json: {}, status: :ok
  end

  # ---------------------------------------

  private

  def recipe_params
    params.require(:recipe).permit(:recipe_name, :recipe_time, :recipe_image)
  end

  def ingredient_params
    params.require(:ingredient).permit(:ingredient_name, :quantity)
  end

  def procedure_params
    params.require(:procedure).permit(:procedure_content, :order, :procedure_image)
  end

  def correct_user
    @recipe = current_api_user.recipes.find(params[:id])
    redirect_to api_top_index_path unless @recipe
  end
end