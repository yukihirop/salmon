require 'rails_helper'

module Api
  module V1
    RSpec.describe UserTokenController, type: :request do

      describe 'POST api_v1_user_token_path (user_token#create)' do
        # !をつけることで保存される。
        let!(:auth_user) { create(:auth_user) }
        let(:auth_user_attributes) { attributes_for(:auth_user) }
        context '正常系' do
          context 'JWT生成成功' do
            let(:auth_user_params) { { :auth => {"email": auth_user_attributes[:email], "password": auth_user_attributes[:password]}}}

            before do
              post api_v1_user_token_path, auth_user_params
            end

            example 'ステータス201(created)が返されること' do
              expect(last_response.status).to eq 201
            end

            example 'JSONに含まれるキーがjwtだけである' do
              expect(json.size).to eq 1
              expect(json).to have_key('jwt')
            end

            example 'JWTをdecodeしてもエラーにならない' do
              expect{ JWT.decode json['jwt'], nil, false }.to_not raise_error
            end
          end
        end

        context '異常系' do
          context 'JWT生成失敗' do
            let(:auth_user_params){ {:auth => {"email": auth_user_attributes[:email], "passsword": "12345"}}}

            before do
              post api_v1_user_token_path, auth_user_params
            end

            example 'ステータス401(not found)が返されること' do
              expect(last_response.status).to eq 404
            end

          end
        end

      end
    end
  end
end



