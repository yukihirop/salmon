require "#{Rails.root}/app/controllers/application_controller.rb"

module Api
  module V1
    class UsersController < ApplicationController

      # この書き方をしないとKnock::Authenticableのmethod_missingに'authenticate_'の部分がひっかかってしまう
      include ActionController::HttpAuthentication::Basic::ControllerMethods
      http_basic_authenticate_with name: "salmon", password: "salmon", only: :index

      before_action :set_user, only: [:show, :update, :destroy]
      before_action :authenticate_user, only: [:show, :update, :destroy]

      # GET /users
      def index
        @users = User.all
        render json: @users
      end

      # GET /users/1
      def show
        if current_user
          render json: @user
        end
      end

      # POST /users
      def create
        @user = User.new(user_params)
        if @user.save
          render json: @user, status: :created
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /users/1
      def update
        if current_user
          if @user.update(user_params)
            render json: @user
          else
            render json: @user.errors, status: :unprocessable_entity
          end
        end
      end

      # DELETE /users/1
      def destroy
        if current_user
          if @user.destroy
            render json: @user
          else
            render json: @user.errors, status: :unprocessable_entity
          end
        end

      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = User.find(params[:id])
      end
      # Only allow a trusted parameter "white list" through.
      def user_params
        params.require(:user).permit(:name, :password, :password_confirmation, :email)
      end

    end
  end
end


