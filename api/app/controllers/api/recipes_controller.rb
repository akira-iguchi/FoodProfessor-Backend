# routes.rbでnamespaceを"api"に設定 -> Api::
class Api::RecipesController < ApplicationController
  # Recipeはゲストが閲覧可能なので, :authenticate_user は定義しない
  before_action :correct_user, only: []

  def create
    @recipe = current_user.recipes.build(recipe_params)
    # 作成成功の可否でjsonを変更
    if @recipe.save
        render json: {
            recipe: @recipe
        }, status: :created
    else
        render json: {}, status: :internal_server_error
    end
  end

  def destroy
    @recipe.destroy
    render json: {}, status: :ok
  end

  # ---------------------------------------

  private

  def recipe_params
    params.require(:recipe).permit(:recipe_name, :recipe_image, :folder_id)
  end

  def correct_user
    @recipe = current_user.recipes.find(params[:id])
    redirect_to root_url unless @recipe
  end
end