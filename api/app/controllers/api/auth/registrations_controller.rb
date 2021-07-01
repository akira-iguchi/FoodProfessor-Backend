class Api::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
  before_action :sign_up_params, only: [:create]
  before_action :update_params, only: [:update]

  private

  def sign_up_params
    params.permit(:email, :password, :password_confirmation, :first_name, :last_name, :profile_image)
  end

  def update_params
    params.permit(:email, :first_name, :last_name, :profile_image)
  end
end
