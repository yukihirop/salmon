#require "#{Rails.root}/app/controllers/application_controller.rb"

module Api
  module V1
    class TodosController < ApplicationController
      #before_action :set_user, only: [:index, :create]
      ## method_missing
      ## authenticate_entity(user)
      ## authenticate_for(user)
      ## current_user
      before_action :authenticate_user
      before_action :set_todo, only: [:show, :update, :destroy]

      # GET /todos
      def index
        @todos = current_user.todos
        render json: @todos
      end

      # GET /todos/1
      def show
        render json:@todo
      end

      # POST /todos
      def create
        @todo = current_user.todos.build(todo_params)
        if @todo.save
          render json: @todo, status: :created
        else
          render json: @todo.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /todos/1
      def update
        if @todo.update(todo_params)
          render json: @todo
        else
          render json: @todo.errors, status: :unprocessable_entity
        end
      end

      # DELETE /todos/1
      def destroy
        if @todo.destroy
          render json: @todo
        else
          render json: @todo.errors, status: :unprocessable_entity
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_todo
        @todo = current_user.todos.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.

      def todo_params
        params.require(:todo).permit(:title, :content, :done)
      end
    end
  end
end


