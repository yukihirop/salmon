require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe 'GET users_path(users#index)' do

    let!(:users) { create_list(:user, 2) }
    let(:users_json_parse) {[]}

    before do
      get users_path
      users_json_parse[0] = JSON.parse(users[0].to_json).except('created_at', 'updated_at')
      users_json_parse[1] = JSON.parse(users[1].to_json).except('created_at', 'updated_at')
    end

    subject do
      JSON.parse(response.body)
    end

    example 'ステータス200(OK)が返されること' do
      expect(response).to be_success
      expect(response.status).to eq 200
    end

    example 'JSONに含まれるkeyが適切であること' do
      2.times do |i|
        expect(subject[i].keys.sort).to include_json(users_json_parse[i].keys.sort)
      end
    end

    example 'JSONに含まれる情報が適切であること' do
      2.times do |i|
        expect(subject[i]).to include_json(users_json_parse[i])
      end
    end

  end

  describe 'POST users_path(users#create)' do

    context '正常系' do
      context 'パスワードと確認パスワードが正しい' do

        let(:dummy_user) { attributes_for(:user)}
        let(:user_params) { {user: dummy_user} }
        # BCryptがpasswordのテストは内部で引き受けてくれる
        let(:user_json_parse) { JSON.parse(dummy_user.to_json).except('id', 'password', 'password_confirmation') }

        before do
          post users_path, params: user_params
        end

        subject do
          JSON.parse(response.body)
        end

        example 'ステータス201(created)が返されること' do
          expect(response).to be_success
          expect(response.status).to eq 201
        end

        example 'データベースにUserが作成されること' do
          expect do
            post users_path, params: user_params
          end.to change(User, :count).by(1)
        end

        example 'JSONに含まれるkeyが適切であること' do
          expect(subject.except('id', 'email_for_index', 'password_digest').keys.sort).to include_json(user_json_parse.keys.sort)
        end

        example 'JSONに含まれる情報が適切であること' do
          expect(subject.except('id','email_for_index', 'password_digest')).to include_json(user_json_parse)
        end
      end
    end

    context '異常系' do

      context 'nameが未記入' do
        let(:user_name_blank_params) { {user: attributes_for(:user_name_blank)} }
        before do
          post users_path, params: user_name_blank_params
        end

        subject do
          JSON.parse(response.body)
        end

        example 'エラーが返ってくること' do
          expect(subject).to be_has_key 'name'
        end

      end

      context 'passwordが未記入' do
        let(:user_password_blank_params) { {user: attributes_for(:user_password_blank)}}
        before do
          post users_path, params: user_password_blank_params
        end

        subject do
          JSON.parse(response.body)
        end

        example 'エラーが返ってくること' do
          expect(subject).to be_has_key 'password'
        end

      end

    end

  end

  describe 'GET user_path(users#show)' do

    context '正常系' do
      let(:user) { create(:user) }
      let(:user_json_parse) { JSON.parse(user.to_json).except('id','created_at', 'updated_at')}

      before do
        get user_path(user)
      end

      subject do
        JSON.parse(response.body)
      end

      example 'ステータス200(OK)が返ってくること' do
        expect(response).to be_success
        expect(response.status).to eq 200
      end

      example 'JSONに含まれる情報が適切であること' do
        expect(subject).to include_json(user_json_parse)
      end

    end

    context '異常系' do

      context '存在しないUserを取得する' do

        before do
          get user_path(id: 0)
        end

        example 'ステータス404(not found)が返されること' do
          expect(response).not_to be_success
          expect(response.status).to eq 404
        end

      end
    end

  end

  describe 'PATCH user_path (user#update)' do

    let(:user) { create(:user) }

    let(:before_user) { {} }
    before do
      before_user['name'] = user.name
      before_user['email'] = user.email
    end

    context '正常系' do

      update_valid_user = {'name' => 'hogehoge', 'email' => 'hogehoge@example.com'}
      update_valid_user.each do |key, val|
        context "有効なパラーメータ(#{key})の場合" do

          before do
            patch user_path(user), params: { user: attributes_for(:user, key => val)}
          end

          example 'ステータス200(OK)が返ってくること' do
            expect(response).to be_success
            expect(response.status).to eq 200
          end

          example "データベースのUser(#{key})が更新されること" do
            user.reload
            expect(user[key]).to eq val
          end

        end
      end
    end

    context '異常系' do

      update_invalid_user = { 'name' => nil, 'email' => nil }
      update_invalid_user.each do |key, val|

        context "無効なパラメータ(#{key})の場合" do

          before do
            patch user_path(user), params: { user: attributes_for(:user, key => val) }
          end

          example 'ステータス422(処理できないエンティティ)が返ってくること' do
            expect(response.status).to eq 422
          end

          example 'データベースのUserの(#{key})は更新されない' do
            user.reload
            expect(user[key]).to eq before_user[key]
          end
        end
      end

      context '要求されたUserが存在しない場合' do

        before do
          patch user_path(id: 0), params: { user: attributes_for(:user, name: 'hogehoge')}
        end

        example 'Content-Typeはtext/htmlであること' do
          expect(response.content_type).to eq('text/html')
        end

        example 'リクエストは404(not found)になること' do
          expect(response.status).to eq 404
        end
      end
    end
  end

  describe 'DELETE user_path(todo#destroy)' do

    context '正常系' do

      let!(:user) { create(:user) }

      subject do
        delete user_path(user)
      end

      example 'ステータス200(OK)を返すこと' do
        subject
        expect(response.status).to eq 200
      end

      example 'データベースから要求されたUserが削除されること' do
        expect{subject}.to change(User, :count).by(-1)
      end
    end

    context '異常系' do

      context '要求されたUserが存在しない場合' do

        before do
          delete user_path(id: 0)
        end

        example 'Content-typeはtext/htmlであること' do
          expect(response.content_type).to eq('text/html')
        end

        example 'ステータス404(not found)が返されること' do
          expect(response.status).to eq 404
        end
      end
    end
  end
end
