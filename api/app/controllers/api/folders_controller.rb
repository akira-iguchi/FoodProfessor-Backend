class Api::FoldersController < ApplicationController
  before_action :authenticate_user
  before_action :correct_user, only: [:destroy]

  def create
    @folder = current_user.folders.build(folder_params)
    if @folder.save
      render json: {
        folder: @folder
      }, status: :created
    else
      render json: {}, status: :internal_server_error
    end
  end

  def update
    @folder = Folder.find(params[:id])
    if @folder.update(folder_params)
      render json: {
        folder: @folder
      }, status: :created
    else
      render json: {}, status: :internal_server_error
    end
  end


  def destroy
    @folder.destroy
    render json: {}, status: :ok
  end

  private

  def folder_params
    params.require(:folder).permit(:folder_name)
  end

  def correct_user
    @folder = current_user.folders.find(params[:id])
    redirect_to root_url unless @folder
  end
end
