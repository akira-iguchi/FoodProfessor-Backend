# routes.rbでnamespaceを"api"に設定 -> Api::
class Api::RecipesController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def show
  end

  def create
    @user = User.find(params[:current_user_id])
    @recipe = @user.recipes.build(recipe_params)
    if @recipe.save       # recipeをsaveしてから、ingredientとprocedureにrecipe_idを付与(recipeが保存されないとidがない)
      @ingredient = @recipe.ingredients.build(ingredient_params)
      @procedure = @recipe.procedures.build(procedure_params)

      if @ingredient.save && @procedure.save
        render json: {}, status: :created
      else
        render json: [
          @recipe.errors,
          @ingredient.errors,
          @procedure.errors
        ], status: 422
      end
    else
      render json: [
        @recipe.errors,
      ], status: 422
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
    render json: {
      recipe: @recipe,
    }, status: :ok
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(update_recipe_params)
        render json: {
            recipe: @recipe
        }, status: :created
    else
        render json: {}, status: :internal_server_error
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    render json: {}, status: :ok
  end

  # ---------------------------------------

  private

  def recipe_params
    params.permit(
      :recipe_name,
      :recipe_time,
      :recipe_image
    )
  end

  def ingredient_params
    params.permit(:ingredient_name, :quantity)
  end

  def procedure_params
    params.permit(:procedure_content, :order, :procedure_image)
  end

  def update_recipe_params
    params.require(:recipe).permit(
      :recipe_name,
      :recipe_time,
      :recipe_image,
      ingredient_attributes: [:ingredient_name, :quantity, :_destroy, :id],
      procedure_attributes: [:procedure_content, :order, :procedure_image, :_destroy, :id]
    )
  end

  def correct_user
    @recipe = current_api_user.recipes.find(params[:id])
    redirect_to api_top_index_path unless @recipe
  end
end