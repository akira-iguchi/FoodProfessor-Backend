class Api::CommentsController < ApplicationController
  before_action :correct_user, only: [:destroy]

  def create
    @user = User.find(params[:current_user_id])
    @comment = @user.comments.build(comment_params)
    @recipe = Recipe.find(params[:recipe_id])
    @comment.recipe_id = @recipe.id
    if @comment.save
      render json: {
        comment: @comment
      }, status: :created
    else
      render json: [@comment.errors], status: 422
    end
  end

  def destroy
    @comment.destroy
    render json: {}, status: :ok
  end

  private

  def comment_params
    params.permit(:comment_content, :comment_image)
  end

  def correct_user
    @comment = current_api_user.comments.find(params[:id])
    redirect_to api_top_index_path unless @comment
  end
end
