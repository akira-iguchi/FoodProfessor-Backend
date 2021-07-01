class Api::CommentsController < ApplicationController
  before_action :authenticate_user

  def create
    @user = User.find(params[:id])
    current_user.follow(@user)
    render json: {}, status: :ok
  end

  def destroy
    @user = User.find(params[:id])
    current_user.unfollow(@user)
    render json: {}, status: :ok
  end
end
