require 'rails_helper'

RSpec.describe "Todos", type: :request do

  let(:user) { create(:user) }

  describe 'GET user_todos_path (todos#index)' do

    let!(:todos) { create_list(:todo, 2, user: user) }
    let(:todos_json_parse) { []}

    before do
      get user_todos_path(user)
      todos_json_parse[0] = JSON.parse(todos[0].to_json).except('updated_at', 'created_at')
      todos_json_parse[1] = JSON.parse(todos[1].to_json).except('updated_at', 'created_at')
    end

    subject do
      JSON.parse(response.body)
    end

    context '正常系' do

      example 'ステータス200(OK)が返されること'  do
        expect(response).to be_success
        expect(response.status).to eq 200
      end

      example 'JSONに含まれるkeyが適切であること' do
        2.times do |i|
          expect(subject[i].keys.sort).to include_json(todos_json_parse[i].keys.sort)
        end
      end

      example 'JSONに含まれる情報がてきせつであること' do
        2.times do |i|
          expect(subject[i]).to include_json(todos_json_parse[i])
        end
      end

    end
  end

  describe 'POST user_todos_path(todos#create)' do

    context '正常系' do

      let(:dummy_todo) { attributes_for(:todo) }
      let(:todo_params) { {todo: dummy_todo} }
      # dummy_todoを用意しないとJSONパースしたデータが用意しにくい
      let(:todo_json_parse) { JSON.parse(dummy_todo.to_json).except('id', 'user_id') }

      before do
        post user_todos_path(user), params: todo_params
      end

      subject do
        JSON.parse(response.body)
      end

      example 'ステータス201(Created)が返されること' do
        expect(response.status).to eq 201
      end

      example 'Todoが作成されること' do
        expect do
          post user_todos_path(user), params: todo_params
        end.to change(Todo, :count).by(1)
      end

      example 'JSONに含まれるkeyが適切であること' do
        expect(subject.except('id', 'user_id')).to include_json(todo_json_parse)
      end

      example 'JSONに含まれる情報が適切であること' do
        expect(subject['user_id']).to eq user['id']
        expect(subject.except('id', 'user_id')).to include_json(todo_json_parse)
      end

    end

    context '異常系' do

      context 'titleが未記入' do

        let(:todo_title_blank_params) { {todo: attributes_for(:todo_title_blank)} }
        before do
          post user_todos_path(user), params: todo_title_blank_params
        end

        subject do
          JSON.parse(response.body)
        end

        example 'エラーが返ってくること' do
          expect(subject).to be_has_key 'title'
        end

      end

    end

  end

  describe 'GET user_todo_path(todos#show)' do

    context '正常系' do

      let(:todo) { create(:todo, user: user) }
      let(:todo_json_parse) { JSON.parse( todo.to_json).except('created_at', 'updated_at') }

      before do
        get user_todo_path(user, todo)
      end

      subject do
        JSON.parse(response.body)
      end

      example 'ステータス200(OK)が返ってくること' do
        expect(response).to be_success
        expect(response.status).to eq 200
      end

      example 'JSONから適切なkeyが取得できること' do
        expect(subject.keys.sort).to include_json(todo_json_parse.keys.sort)
      end

      example 'JSONから適切な情報を取得できること' do
        expect(subject).to include_json(todo_json_parse)
      end

    end

    context '異常系' do

      before do
        get user_todo_path(user_id: user.id, id:0 )
      end

      context '存在しないTodoを取得する' do

        example 'ステータス404(not found)が返されること' do
          expect(response).not_to be_success
          expect(response.status).to eq 404
        end
      end

    end

  end

  describe 'PATCH user_todo_path(todos#update)' do

    let(:todo) { create(:todo, user: user) }

    context '正常系' do

      update_valid_todo = {'title'  => 'hogehoge', 'content' => 'hogehoge', 'done' => true }
      update_valid_todo.each do |key, val|
        context "有効なパラメータ(#{key})の場合" do

          before do
            patch user_todo_path(user, todo), params: { todo: attributes_for(:todo, key => val )}
          end

          example 'ステータス200(OK)が返ってくること' do
            expect(response).to be_success
            expect(response.status).to eq 200
          end

          example "データベースのTodoの(#{key})が更新されること" do
            todo.reload
            expect(todo[key]).to eq val
          end
        end
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
            patch user_todo_path(user, todo), params: {todo: attributes_for(:todo, key => val )}
          end

          example 'ステータス422(処理できないエンティティ)が返ってくること' do
            expect(response.status).to eq 422
          end

          example "データベースのTodoの(#{key})は更新されない" do
            todo.reload
            expect(todo[key]).to eq before_todo[key]
          end

        end
      end

      context '要求されたTodoが存在しない場合' do

        before do
          patch user_todo_path(user_id: user.id, id: 0), params: {todo: attributes_for(:todo, title: 'hogehoge')}
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

  describe 'DELETE user_todo_path(todo#destroy)' do

    context '正常系' do

      let!(:todo) { create(:todo, user: user) }

      subject do
        delete user_todo_path(user, todo)
      end

      example 'ステータス200(OK)を返すこと' do
        subject
        expect(response.status).to eq 200
      end

      example 'データベースから要求されたTodoが削除されること' do
        expect{subject}.to change(Todo, :count).by(-1)
      end

    end

    context '異常系' do

      context '要求されたTodoが存在しない場合' do

        before do
          delete user_todo_path(user_id: user.id, id: 0)
        end

        example 'Content-Typeはtext/htmlであること' do
          expect(response.content_type).to eq('text/html')
        end

        example 'ステータス404(not found)が返されること' do
          expect(response.status).to eq 404
        end

      end

    end

  end

end
