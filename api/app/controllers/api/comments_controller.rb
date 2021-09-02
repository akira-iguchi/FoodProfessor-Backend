class Api::CommentsController < ApplicationController
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
    @comment = Comment.find(params[:id])
    @comment.destroy
    render json: {}, status: :ok
  end

  private

  def comment_params
    params.permit(:comment_content, :comment_image)
  end
end
