class Api::CommentsController < ApplicationController
  def follow
    @user = User.find(params[:id])
    current_api_user.follow(@user)
    render json: {
      user: @user
    }, status: :ok
  end

  def unfollow
    @user = User.find(params[:id])
    current_api_user.unfollow(@user)
    render json: {
      user: @user
    }, status: :ok
  end
end
