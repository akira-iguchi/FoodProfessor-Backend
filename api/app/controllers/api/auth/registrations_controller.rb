class Api::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
  private

  def sign_up_params
    params.permit(:email, :password, :password_confirmation, :first_name, :last_name, :profile_image)
  end

  def account_update_params
    params.permit(:email, :first_name, :last_name, :profile_image)
  end
end
