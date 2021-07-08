# API運用のため -::API で設定(config/application.rbも)
class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  skip_before_action :verify_authenticity_token, raise: false
end
