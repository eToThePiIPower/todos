class TodoListsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :authorize_ownership!, only: [:edit, :update, :show, :destroy]

  def index
    if current_user
      @todo_lists = current_user.todo_lists
    else
      @todo_lists = []
      render :welcome
    end
  end

  def show
    @todo_items = @todo_list.todo_items.priority
    @todo_item = @todo_list.todo_items.new
  end

  def new
    @todo_list = current_user.todo_lists.new
  end

  def edit
  end

  def create
    @todo_list = current_user.todo_lists.new(todo_list_params)
    if @todo_list.save
      flash[:notice] = 'Todo List successfully created.'
      redirect_to @todo_list
    else
      flash.now[:error] = 'Validation errors.'
      render :new
    end
  end

  def update
    if @todo_list.update(todo_list_params)
      flash[:notice] = 'Todo List successfully updated.'

      redirect_to @todo_list, status: :see_other
    else
      flash.now[:error] = 'Validation errors.'
      render :edit
    end
  end

  def destroy
    @todo_list.destroy
    redirect_to todo_lists_url, status: :see_other
  end

  private

  def authorize_ownership!
    @todo_list = current_user.todo_lists.find_by_id(params.fetch(:id))
    if @todo_list.nil?
      flash[:alert] = 'You are not the owner of that list or the list does not exist.'
      redirect_to root_path
    end
  end

  def todo_list_params
    params.require(:todo_list).permit(:name, :description)
  end
end
