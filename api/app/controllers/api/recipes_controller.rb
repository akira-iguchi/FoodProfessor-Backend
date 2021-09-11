# routes.rbでnamespaceを"api"に設定 -> Api::
class Api::RecipesController < ApplicationController
  include ActionController::Cookies

  def show
    @recipe = Recipe.find(params[:id])
    @user = @recipe.user
    @ingredients = @recipe.ingredients
    @procedures = @recipe.procedures
    @categories = @recipe.categories
    @comments = @recipe.comments.order(id: :desc)
    # コメントの投稿者がinclude等で取得できないので、ユーザーを全て取得してからフロントで処理
    @comment_users = User.all
    @favorite_users = @recipe.favorite_users
    @is_favorite = @recipe.is_favorite?(current_api_user)
    render json: {
      recipe: @recipe,
      user: @user,
      ingredients: @ingredients,
      procedures: @procedures,
      categories: @categories,
      comments: @comments,
      comment_users: @comment_users,
      favorite_users: @favorite_users,
      is_favorite: @is_favorite,
    }, status: :ok
  end

  def create
    @user = User.find(params[:current_user_id])
    @recipe = @user.recipes.build(recipe_params)
    Recipe.transaction do  # transactionで失敗時に処理をすべてロールバックする
      @recipe.save!       # recipeを保存してから、ingredientとprocedureにrecipe_idを付与(recipeが保存されないとidがない)
      JSON.parse(params[:ingredient_params]).each do |ingredient_params|
        @ingredient = @recipe.ingredients.build(ingredient_params)
        @ingredient.save!
      end
      JSON.parse(params[:categories]).each do |category_name|
        @category = Category.find_or_create_by!(category_name: category_name)
        @category.recipe_relation(@recipe)
      end
      JSON.parse(params[:procedure_params]).each do |procedure_params|
        @procedure = @recipe.procedures.build(procedure_params)
        @procedure.save!
      end
    end
      render json: {recipe: @recipe}, status: :created
    rescue => errors
      render json: [
        errors,
      ], status: 422
  end

  def edit
    @recipe = Recipe.find(params[:id])
    # selectメソッドは「id: null」も付いていくるので、「as_json(:except => :id)」で除去
    @ingredients = @recipe.ingredients.select(:ingredient_name, :quantity).as_json(:except => :id)
    @procedures = @recipe.procedures.select(:procedure_content).as_json(:except => :id)
    @categories = @recipe.categories.pluck(:category_name)
    render json: {
      recipe: @recipe,
      ingredients: @ingredients,
      procedures: @procedures,
      categories: @categories,
    }, status: :ok
  end

  def update
    @user = User.find(params[:current_user_id])
    @recipe = Recipe.find(params[:id])
    Recipe.transaction do  # transactionで失敗時に処理をすべてロールバックする
      @recipe.update!(recipe_params)       # recipeを保存してから、ingredientとprocedureにrecipe_idを付与(recipeが保存されないとidがない)
      # 子テーブル削除
      @recipe.ingredients.destroy_all
      @recipe.recipe_category_relations.destroy_all
      @recipe.procedures.destroy_all
      JSON.parse(params[:ingredient_params]).each do |ingredient_params|
        @ingredient = @recipe.ingredients.build(ingredient_params)
        @ingredient.save!
      end
      JSON.parse(params[:categories]).each do |category_name|
        @category = Category.find_or_create_by!(category_name: category_name)
        @category.recipe_relation(@recipe)
      end
      JSON.parse(params[:procedure_params]).each do |procedure_params|
        @procedure = @recipe.procedures.build(procedure_params)
        @procedure.save!
      end
    end
      render json: {recipe: @recipe}, status: :created
    rescue => errors
      render json: [
        errors,
      ], status: 422
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
      :for_how_many_people,
      :recipe_image
    )
  end

  def ingredient_params
    params.permit(:ingredient_name, :quantity)
  end

  def procedure_params
    params.permit(:procedure_content)
  end
end