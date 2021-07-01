class Api::CommentsController < ApplicationController
  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes.order(id: :desc)
    @folders = @user.folders.order(id: :desc)
    @followings = @user.followings.order(id: :desc)
    @followers = @user.followers.order(id: :desc)
    render json: {
      user: user,
      recipes: recipes,
      folders: folders,
      followings: followings,
      followers: followers
    }, status: :ok
  end

  private

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_url unless @user == current_user
  end
end
