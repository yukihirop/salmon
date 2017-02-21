module Requests
  module AuthHelper


    def authenticate(user)
      @env ||= {}
      token = Knock::AuthToken.new(payload: { sub: user.id}).token
      @env['HTTP_AUTHORIZATION'] = "{Bearer #{token}"
    end

    def current_auth_user(user)
      allow(controller).to receive(:current_user).and_return(user)
    end

    def http_basic_authenticate
      @env ||= {}
      # FIXME: 環境変数にする
      username, password = 'salmon','salmon'
      @env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(username, password)
    end

  end
end

RSpec.configure do |config|
  config.include Requests::AuthHelper, :type=>:request
end