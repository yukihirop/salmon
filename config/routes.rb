Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/user_token' => 'user_token#create'
      resources :users, :defaults => {:format => 'json'} do
        resources :todos
      end
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
