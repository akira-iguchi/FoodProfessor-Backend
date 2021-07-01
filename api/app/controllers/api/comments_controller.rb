class Api::CommentsController < ApplicationController
  before_action :authenticate_user
  before_action :correct_user, only: [:destroy]

  def create
    @comment = current_user.comments.build(comment_params)
    @recipe = Recipe.find(params[:spot_id])
    @comment.spot_id = @recipe.id
    if @comment.save
      render json: {
        comment: @comment
      }, status: :created
    else
      render json: {}, status: :internal_server_error
    end
  end

  def destroy
    @comment.destroy
    render json: {}, status: :ok
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_content, :comment_image)
  end

  def correct_user
    @comment = current_user.comments.find(params[:id])
    redirect_to root_url unless @comment
  end
end
