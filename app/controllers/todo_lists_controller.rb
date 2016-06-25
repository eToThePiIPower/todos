class TodoListsController < ApplicationController
  before_action :set_todo_list, only: [:show, :edit, :update, :destroy]
  def index
    @todo_lists = TodoList.all
  end

  def show
    @todo_items = @todo_list.todo_items
  end

  def edit
  end

  def update
    if @todo_list.update(todo_list_params)
      flash[:notice] = 'Todo List successfully updated.'
      redirect_to @todo_list
    else
      flash[:error] = 'Validation errors.'
      render :edit
    end
  end

  def new
    @todo_list = TodoList.new
  end

  def create
    @todo_list = TodoList.new(todo_list_params)
    if @todo_list.save
      flash[:notice] = 'Todo List successfully created.'
      redirect_to @todo_list
    else
      flash[:error] = 'Validation errors.'
      render :new
    end
  end

  def destroy
    @todo_list.destroy
    redirect_to todo_lists_url
  end

  private

  def set_todo_list
    @todo_list = TodoList.find(params[:id])
  end

  def todo_list_params
    params.require(:todo_list).permit(:name, :description)
  end
end
