require 'rails_helper'

module Api
  module V1
    RSpec.describe UsersController, type: :request do

      let!(:auth_user) { create(:auth_user) }

      describe 'GET api_v1_users_path(users#index)' do

        let!(:user) { create(:user) }
        let(:users_json_parse) {[]}

        before do
          http_basic_authenticate
          get api_v1_users_path,{}, @env
          users_json_parse[0] = JSON.parse(auth_user.to_json).except('password_digest','created_at', 'updated_at')
          users_json_parse[1] = JSON.parse(user.to_json).except('password_digest','created_at', 'updated_at')
        end

        example 'ステータス200(OK)が返されること' do
          expect(last_response.status).to eq 200
        end

        example 'JSONに含まれるkeyが適切であること' do
          2.times do |i|
            expect(json[i].keys.sort).to include_json(users_json_parse[i].keys.sort)
          end
        end

        example 'JSONに含まれる情報が適切であること' do
          2.times do |i|
            expect(json[i]).to include_json(users_json_parse[i])
          end
        end

        context 'JWT認証に失敗した場合' do
          let(:path) { "/api/v1/users" }
          let(:params) { {} }
          it_behaves_like 'Basic Authorization failed(HTTP 401)', :get
        end

      end

      describe 'POST users_path(users#create)' do

        context '正常系' do
          context 'パスワードと確認パスワードが正しい' do

            let(:dummy_user) { attributes_for(:user)}
            let(:user_params) { {user: dummy_user} }
            # BCryptがpasswordのテストは内部で引き受けてくれる
            let(:user_json_parse) { JSON.parse(dummy_user.to_json).except('id', 'password', 'password_confirmation') }

            subject do
              post api_v1_users_path, user_params
            end

            example 'データベースにUserが作成されること' do
              expect { subject }.to change(User, :count).by(1)
            end

            example 'ステータス201(created)が返されること' do
              subject
              expect(last_response.status).to eq 201
            end

            example 'JSONに含まれるkeyが適切であること' do
              subject
              expect(json.except('id','password_digest').keys.sort).to include_json(user_json_parse.keys.sort)
            end

            example 'JSONに含まれる情報が適切であること' do
              subject
              expect(json.except('id','password_digest')).to include_json(user_json_parse)
            end
          end
        end

        context '異常系' do

          context 'nameが未記入' do
            let(:user_name_blank_params) { {user: attributes_for(:user_name_blank)} }

            before do
              post api_v1_users_path, user_name_blank_params
            end

            example 'エラーが返ってくること' do
              expect(json).to be_has_key 'name'
            end

          end

          context 'passwordが未記入' do
            let(:user_password_blank_params) { {user: attributes_for(:user_password_blank)}}
            before do
              post api_v1_users_path, user_password_blank_params
            end

            example 'エラーが返ってくること' do
              expect(json).to be_has_key 'password'
            end
          end
        end
      end

      describe 'GET api_v1_user_path(users#show)' do

        context '正常系' do
          let(:auth_user_json_parse) { JSON.parse(auth_user.to_json).except('id','password_digest','created_at', 'updated_at')}

          before do
            current_auth_user(auth_user)
            authenticate(auth_user)
            get api_v1_user_path(id: auth_user.id), {}, @env
          end


          example 'ステータス200(OK)が返ってくること' do
            expect(last_response.status).to eq 200
          end

          example 'JSONに含まれる情報が適切であること' do
            expect(json).to include_json(auth_user_json_parse)
          end

          context 'JWT認証に失敗した場合' do
            let(:path) { "/api/v1/users/#{auth_user.id}" }
            let(:params) { {}}
            it_behaves_like 'JWT Authorization failed(HTTP 401)', :get
          end

        end

        context '異常系' do

          context '存在しないUserを取得する' do

            before do
              current_auth_user(auth_user)
              authenticate(auth_user)
              get api_v1_user_path(id: 0), {}, @env
            end

            example 'ステータス404(not found)が返されること' do
              expect(last_response.status).to eq 404
            end

          end
        end

      end

      describe 'PATCH api_v1_user_path (user#update)' do

        let(:before_user) { {} }
        before do
          before_user['name'] = auth_user.name
          before_user['email'] = auth_user.email
        end

        context '正常系' do

          update_valid_user = {'name' => 'hogehoge', 'email' => 'hogehoge@example.com'}
          update_valid_user.each do |key, val|
            context "有効なパラーメータ(#{key})の場合" do

              before do
                current_auth_user(auth_user)
                authenticate(auth_user)
                patch api_v1_user_path(id: auth_user.id), { user: attributes_for(:user, key => val)}, @env
              end

              example 'ステータス200(OK)が返ってくること' do
                expect(last_response.status).to eq 200
              end

              example "データベースのUser(#{key})が更新されること" do
                auth_user.reload
                expect(auth_user[key]).to eq val
              end

            end
          end

          context 'JWT認証に失敗した場合' do
            let(:path) { "/api/v1/users/#{auth_user.id}" }
            let(:params) { {user: attributes_for(:user, 'name' => 'hogehoge')} }
            it_behaves_like 'JWT Authorization failed(HTTP 401)', :patch
          end

        end

        context '異常系' do

          update_invalid_user = { 'name' => nil, 'email' => nil }
          update_invalid_user.each do |key, val|

            context "無効なパラメータ(#{key})の場合" do

              before do
                current_auth_user(auth_user)
                authenticate(auth_user)
                patch api_v1_user_path(id: auth_user.id), { user: attributes_for(:user, key => val) }, @env
              end

              example 'ステータス422(処理できないエンティティ)が返ってくること' do
                expect(last_response.status).to eq 422
              end

              example 'データベースのUserの(#{key})は更新されない' do
                auth_user.reload
                expect(auth_user[key]).to eq before_user[key]
              end
            end
          end

          context '要求されたUserが存在しない場合' do

            before do
              current_auth_user(auth_user)
              authenticate(auth_user)
              patch api_v1_user_path(id: 0), { user: attributes_for(:user, name: 'hogehoge')}, @env
            end

            example 'リクエストは404(not found)になること' do
              expect(last_response.status).to eq 404
            end
          end
        end
      end

      describe 'DELETE api_v1_user_path(todo#destroy)' do

        context 'JWT認証に失敗した場合' do
          let(:path) { "/api/v1/users/#{auth_user.id}" }
          let(:params) { { } }
          it_behaves_like 'JWT Authorization failed(HTTP 401)', :delete
        end

        context '正常系' do

          subject do
            current_auth_user(auth_user)
            authenticate(auth_user)
            delete api_v1_user_path(id: auth_user.id), {}, @env
          end

          example 'ステータス200(OK)を返すこと' do
            subject
            expect(last_response.status).to eq 200
          end

          example 'データベースから要求されたUserが削除されること' do
            expect{subject}.to change(User, :count).by(-1)
          end


        end

        context '異常系' do

          context '要求されたUserが存在しない場合' do

            before do
              current_auth_user(auth_user)
              authenticate(auth_user)
              delete api_v1_user_path(id: 0), {}, @env
            end

            example 'ステータス404(not found)が返されること' do
              expect(last_response.status).to eq 404
            end
          end
        end
      end
    end
  end
end



