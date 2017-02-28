require 'jwt'
#require "#{Rails.root}/app/controllers/application_controller.rb"

module Api
  module V1
    class UserTokenController < Knock::AuthTokenController

      def create
        super
        jwt_set_cookies
      end

      private

      def json_parse_response
        # 例) {"jwt"=>"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE0ODczNDAyODQsInN1YiI6MX0.Bpk0huCG23yju58Yrj1fG6-Sa_zjXh0K1-z0edYPU"}
        JSON.parse(response.body)
      end

      def current_user_hash
        # 例)  [{"exp"=>1487349607, "sub"=>1}, {"type"=>"JWT", "alg"=>"HS256"}]
        JWT.decode json_parse_response['jwt'], nil, false
      end

      def jwt_set_cookies
        auth_user_id = "auth_user_#{current_user_hash[0]['sub']}".to_sym
        cookies[auth_user_id] = { :value => json_parse_response['jwt'], :expires => 1.hour.from_now }
      end

    end
  end
end

