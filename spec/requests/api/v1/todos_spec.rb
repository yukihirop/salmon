require 'rails_helper'
module Api
  module V1
    RSpec.describe TodosController, type: :request do

      let!(:auth_user) { create(:auth_user) }

      describe 'GET api_v1_user_todos_path (todos#index)' do

        context '正常系' do

          let!(:todos) { create_list(:todo, 2, user: auth_user) }
          let(:todos_json_parse) { []}

          before do
            current_auth_user(auth_user)
            # @env["HTTP_AUTHORIZATION"]の設定
            authenticate(auth_user)
            get api_v1_user_todos_path(:current_user),{}, @env
            todos_json_parse[0] = JSON.parse(todos[0].to_json).except('updated_at', 'created_at')
            todos_json_parse[1] = JSON.parse(todos[1].to_json).except('updated_at', 'created_at')
          end

          example 'ステータス200(OK)が返されること'  do
            expect(last_response.status).to eq 200
          end

          example 'JSONに含まれるkeyが適切であること' do
            2.times do |i|
              expect(json[i].keys.sort).to include_json(todos_json_parse[i].keys.sort)
            end
          end

          example 'JSONに含まれる情報がてきせつであること' do
            2.times do |i|
              expect(json[i]).to include_json(todos_json_parse[i])
            end
          end

          context 'JWT認証に失敗した場合' do
            let(:path) { "/api/v1/users/#{auth_user.id}/todos" }
            let(:params) { {}}
            it_behaves_like 'JWT Authorization failed(HTTP 401)', :get
          end
        end
      end

      describe 'POST api_v1_user_todos_path(todos#create)' do

        context '正常系' do

          let(:dummy_todo) { attributes_for(:todo) }
          let(:todo_params) { {todo: dummy_todo} }
          # dummy_todoを用意しないとJSONパースしたデータが用意しにくい
          let(:todo_json_parse) { JSON.parse(dummy_todo.to_json).except('id', 'user_id') }

          subject do
            current_auth_user(auth_user)
            authenticate(auth_user)
            post api_v1_user_todos_path(:current_user), todo_params, @env
          end

          example 'ステータス201(Created)が返されること' do
            subject
            expect(last_response.status).to eq 201
          end

          example 'Todoが作成されること' do
            expect{ subject}.to change(Todo, :count).by(1)
          end

          example 'JSONに含まれるkeyが適切であること' do
            subject
            expect(json.except('id', 'user_id')).to include_json(todo_json_parse)
          end

          example 'JSONに含まれる情報が適切であること' do
            subject
            expect(json['user_id']).to eq auth_user['id']
            expect(json.except('id', 'user_id')).to include_json(todo_json_parse)
          end

          context 'JWT認証に失敗した場合' do
            let(:path) { "/api/v1/users/#{auth_user.id}/todos" }
            let(:params) { todo_params}
            it_behaves_like 'JWT Authorization failed(HTTP 401)', :post
          end

        end

        context '異常系' do

          context 'titleが未記入' do

            let(:todo_title_blank_params) { {todo: attributes_for(:todo_title_blank)} }
            before do
              current_auth_user(auth_user)
              authenticate(auth_user)
              post api_v1_user_todos_path(:current_user), todo_title_blank_params, @env
            end

            example 'エラーが返ってくること' do
              expect(json).to be_has_key 'title'
            end

          end

        end

      end

      describe 'GET api_v1_user_todo_path(todos#show)' do

        context '正常系' do

          let(:todo) { create(:todo, user: auth_user) }
          let(:todo_json_parse) { JSON.parse( todo.to_json).except('created_at', 'updated_at') }

          before do
            current_auth_user(auth_user)
            authenticate(auth_user)
            get api_v1_user_todo_path(:current_user, todo),{},@env
          end

          example 'ステータス200(OK)が返ってくること' do
            expect(last_response.status).to eq 200
          end

          example 'JSONから適切なkeyが取得できること' do
            expect(json.keys.sort).to include_json(todo_json_parse.keys.sort)
          end

          example 'JSONから適切な情報を取得できること' do
            expect(json).to include_json(todo_json_parse)
          end

          context 'JWT認証に失敗した場合' do
            let(:path) { "/api/v1/users/#{auth_user.id}/todos/#{todo.id}" }
            let(:params) { {} }
            it_behaves_like 'JWT Authorization failed(HTTP 401)', :get
          end

        end

        context '異常系' do

          before do
            current_auth_user(auth_user)
            authenticate(auth_user)
            get api_v1_user_todo_path(:current_user, id:0 ), {}, @env
          end

          context '存在しないTodoを取得する' do

            example 'ステータス404(not found)が返されること' do
              expect(last_response.status).to eq 404
            end
          end

        end

      end

      describe 'PATCH api_v1_user_todo_path(todos#update)' do

        let(:todo) { create(:todo, user: auth_user) }

        context '正常系' do

          update_valid_todo = {'title'  => 'hogehoge', 'content' => 'hogehoge', 'done' => true }
          update_valid_todo.each do |key, val|
            context "有効なパラメータ(#{key})の場合" do

              before do
                current_auth_user(auth_user)
                authenticate(auth_user)
                patch api_v1_user_todo_path(:current_user, todo), { todo: attributes_for(:todo, key => val )}, @env
              end

              example 'ステータス200(OK)が返ってくること' do
                expect(last_response.status).to eq 200
              end

              example "データベースのTodoの(#{key})が更新されること" do
                todo.reload
                expect(todo[key]).to eq val
              end
            end
          end

          context 'JWT認証に失敗した場合' do
            let(:path) { "/api/v1/users/#{auth_user.id}/todos/#{todo.id}" }
            let(:params) { {todo: attributes_for(:todo, 'title' => 'hogehoge')} }
            it_behaves_like 'JWT Authorization failed(HTTP 401)', :patch
          end

        end

        let(:before_todo) { {} }
        before do
          before_todo['title'] = todo.title
          before_todo['content'] = todo.content
          before_todo['done'] = todo.done
        end

        context '異常系' do

          update_invalid_todo = {'title'  => nil, 'content' => nil, 'done' => nil }
          update_invalid_todo.each do |key, val|
            context "無効なパラメータ(#{key})の場合" do

              before do
                current_auth_user(auth_user)
                authenticate(auth_user)
                patch api_v1_user_todo_path(:current_user, todo), {todo: attributes_for(:todo, key => val )}, @env
              end

              example 'ステータス422(処理できないエンティティ)が返ってくること' do
                expect(last_response.status).to eq 422
              end

              example "データベースのTodoの(#{key})は更新されない" do
                todo.reload
                expect(todo[key]).to eq before_todo[key]
              end

            end
          end

          context '要求されたTodoが存在しない場合' do

            before do
              current_auth_user(auth_user)
              authenticate(auth_user)
              patch api_v1_user_todo_path(:current_user, id: 0), {todo: attributes_for(:todo, title: 'hogehoge')}, @env
            end


            example 'リクエストは404(not found)になること' do
              expect(last_response.status).to eq 404
            end
          end

        end

      end

      describe 'DELETE api_v1_user_todo_path(todo#destroy)' do

        context '正常系' do

          let!(:todo) { create(:todo, user: auth_user) }

          subject do
            current_auth_user(auth_user)
            authenticate(auth_user)
            delete api_v1_user_todo_path(:current_user, todo), {}, @env
          end

          example 'ステータス200(OK)を返すこと' do
            subject
            expect(last_response.status).to eq 200
          end

          example 'データベースから要求されたTodoが削除されること' do
            expect{subject}.to change(Todo, :count).by(-1)
          end

          context 'JWT認証に失敗した場合' do
            let(:path) { "/api/v1/users/#{auth_user.id}/todos/#{todo.id}" }
            let(:params) {{}}
            it_behaves_like 'JWT Authorization failed(HTTP 401)', :delete
          end

        end

        context '異常系' do

          context '要求されたTodoが存在しない場合' do

            before do
              current_auth_user(auth_user)
              authenticate(auth_user)
              delete api_v1_user_todo_path(:current_user, id: 0),{},@env
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




