class Api::UsersController < ApplicationController
  before_action :correct_user

  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes.order(id: :desc)
    @folders = @user.folders.order(id: :desc)
    @followings = @user.followings.order(id: :desc)
    @followers = @user.followers.order(id: :desc)
    render json: {
      user: @user,
      recipes: @recipes,
      folders: @folders,
      followings: @followings,
      followers: @followers
    }, status: :ok
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.order(id: :desc)
    render json: {
      user: @user,
      followings: @followings,
    }, status: :ok
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.order(id: :desc)
    render json: {
      user: @user,
      followers: @followers,
    }, status: :ok
  end

  def folders
    @user = User.find(params[:id])
    @folders = @user.folders.order(id: :desc)
    render json: {
      user: @user,
      folders: @folders,
    }, status: :ok
  end

  def folders
    @user = User.find(params[:id])
    @folders = @user.folders.order(id: :desc)
    render json: {
      user: @user,
      folders: @folders,
    }, status: :ok
  end

  # def favorite_recipes
  #   @user = User.find(params[:id])
  #   @favorite_recipes = @user.favorite_recipes.order(id: :desc)
  #   render json: {
  #     user: @user,
  #     favorite_recipes: @favorite_recipes,
  #   }, status: :ok
  # end

  private

  def correct_user
    @user = User.find(params[:id])
    redirect_to api_root_url unless @user == current_api_user
  end
end
