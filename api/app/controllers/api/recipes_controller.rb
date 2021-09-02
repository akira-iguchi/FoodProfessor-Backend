# routes.rbでnamespaceを"api"に設定 -> Api::
class Api::RecipesController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def show
    @recipe = Recipe.find(params[:id])
    @user = @recipe.user
    @ingredients = @recipe.ingredients
    @procedures = @recipe.procedures
    @categories = @recipe.categories
    @comments = @recipe.comments.order(id: :desc)
    # コメントの投稿者がinclude等で取得できないので、ユーザーを全て取得してからフロントで処理
    @comment_users = User.all
    @favorites = @recipe.favorites
    render json: {
      recipe: @recipe,
      user: @user,
      ingredients: @ingredients,
      procedures: @procedures,
      categories: @categories,
      comments: @comments,
      comment_users: @comment_users,
      favorites: @favorites
    }, status: :ok
  end

  def create
    @user = User.find(params[:current_user_id])
    @recipe = @user.recipes.build(recipe_params)
    Recipe.transaction do  # transactionで失敗時に処理をすべてロールバックする
        @recipe.save!       # recipeを保存してから、ingredientとprocedureにrecipe_idを付与(recipeが保存されないとidがない)
        @ingredient = @recipe.ingredients.build(ingredient_params)
        @procedure = @recipe.procedures.build(procedure_params)

        if @ingredient.save! && @procedure.save!
          render json: {}, status: :created
        else
          render json: [
            @recipe.errors,
            @ingredient.errors,
            @procedure.errors
          ], status: 422
        end
    end
      render json: {}, status: :created
    rescue => errors
      render json: [
        errors,
      ], status: 422
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

  def search
    @recipes = if params[:recipe_name] === 'none'
              Recipe.all
            else
              Recipe.where(['recipe_name LIKE ?', "%#{params[:recipe_name]}%"]).order(id: :desc)
            end
    render json: {
      search_recipes: @recipes
    }, status: :ok
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
    params.permit(:procedure_content)
  end

  def update_recipe_params
    params.require(:recipe).permit(
      :recipe_name,
      :recipe_time,
      :recipe_image,
      ingredient_attributes: [:ingredient_name, :quantity, :_destroy, :id],
      procedure_attributes: [:procedure_content, :order, :_destroy, :id]
    )
  end

  def correct_user
    @recipe = current_api_user.recipes.find(params[:id])
    redirect_to api_top_index_path unless @recipe
  end
end