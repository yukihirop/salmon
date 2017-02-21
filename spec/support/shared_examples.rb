require 'rails_helper'

shared_examples 'JWT Authorization failed(HTTP 401)' do |method|
  before do
    # Rspec.describe do ・・・endとスコープは同じ
    # path,paramsは呼び出し先で与える必要がある。
    if auth_user
      # @envが初期化されている。
      authenticate(auth_user)
      # わざと認証失敗させる
      @env['HTTP_AUTHORIZATION'] = "{Bearer badhttpauthorizationjsonwebtoken}"
      send(method, path, params, @env)
    end
  end

  it 'ステータス401(認証エラー)が返される' do
    expect(last_response.status).to eq 401
  end

end

shared_examples 'Basic Authorization failed(HTTP 401)' do |method|
  before do
    # @envが初期化されている。
    http_basic_authenticate
    # わざと認証を失敗させる
    # FIXME: 環境変数にする
    username, password = 'bad','basic'
    @env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(username, password)
    send(method, path, params, @env)
  end

  it 'ステータス401(認証エラー)が返される' do
    expect(last_response.status).to eq 401
  end

end