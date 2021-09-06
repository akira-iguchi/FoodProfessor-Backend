class Api::CommentsController < ApplicationController
  def create
    @user = User.find(params[:current_user_id])
    @comment = @user.comments.build(comment_params)
    @recipe = Recipe.find(params[:recipe_id])
    @comment.recipe_id = @recipe.id
    if @comment.save
      render json: {
        comments: @recipe.comments.order(id: :desc)
      }, status: :created
    else
      render json: [@comment.errors], status: 422
    end
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    render json: {
      comments: @recipe.comments.order(id: :desc)
    }, status: :ok
  end

  private

  def comment_params
    params.permit(:comment_content, :comment_image)
  end
end
