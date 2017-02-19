class ApplicationController < ActionController::API
  include Knock::Authenticable
  # cookiesを使うために
  include ActionController::Cookies


  def token
    id = params[:user_id]
    auth_user_id = "auth_user_#{id}".to_sym
    params[:token] || token_from_request_headers || cookies[auth_user_id]
  end

end
