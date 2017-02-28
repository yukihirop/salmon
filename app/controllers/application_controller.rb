class ApplicationController < ActionController::API
  include Knock::Authenticable
  # cookiesを使うために
  include ActionController::Cookies


  def token
    auth_user_id = "auth_user_#{id}".to_sym
    params[:token] || token_from_request_headers || cookies[auth_user_id]
  end

  def id
    params[:user_id] if self.is_a?(Api::V1::TodosController)
    params[:id] if self.is_a?(Api::V1::UsersController)
  end

end
