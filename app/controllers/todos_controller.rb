class TodosController < ApplicationController
  before_action :set_user, only: [:index, :create]
  before_action :set_todo, only: [:show, :update, :destroy]

  # GET /todos
  def index
    @todos = @user.todos
    render json: @todos
  end

  # GET /todos/1
  def show
    render json: @todo
  end

  # POST /todos
  def create
    @todo = @user.todos.build(todo_params)
    if @todo.save
      render json: @todo, status: :created, location: [@user, @todo]
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
    @todo = Todo.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  # Only allow a trusted parameter "white list" through.

  def todo_params
    params.require(:todo).permit(:title, :content, :done)
  end

end
