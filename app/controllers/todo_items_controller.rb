class TodoItemsController < ApplicationController
  before_action :authenticate_user!, only: [:destroy, :create, :complete, :uncomplete, :update]
  before_action :authorize_ownership!, only: [:destroy, :complete, :uncomplete, :update]
  before_action :authorize_ownership_of_list!, only: :create
  respond_to :html, :js

  def create
    @todo_item = @todo_list.todo_items.new(todo_item_params)

    respond_to do |f|
      if @todo_item.save
        f.html { redirect_to @todo_list, flash: { notice: 'Item successfully added.' } }
        f.js
      else
        f.html { redirect_to @todo_list, flash: { error: 'Error adding item.' } }
        f.js { render 'error' }
      end
    end
  end

  def update
    if @todo_item.update(todo_item_params)
      flash[:notice] = 'Todo Item successfully updated.'
    else
      flash[:error] = 'Validation errors.'
    end
    redirect_to @todo_item.todo_list, status: :see_other
  end

  def destroy
    @todo_list = @todo_item.todo_list

    @todo_item.destroy

    flash[:notice] = 'Item successfully deleted.'
    redirect_to @todo_list, status: :see_other
  end

  def complete
    @todo_item.complete!
    @todo_item.save
    respond_to do |f|
      f.html { redirect_to @todo_item.todo_list, status: :see_other }
      f.js
    end
  end

  def uncomplete
    @todo_item.uncomplete!
    @todo_item.save
    respond_to do |f|
      f.html { redirect_to @todo_item.todo_list, status: :see_other }
      f.js
    end
  end

  private

  def authorize_ownership!
    @todo_item = current_user.todo_items.find_by_id(params.fetch(:id))
    if @todo_item.nil?
      flash[:alert] = 'You are not the owner of that item or the item does not exist.'
      redirect_to root_path
    else
      @todo_list = @todo_item.todo_list
    end
  end

  def authorize_ownership_of_list!
    @todo_list = current_user.todo_lists.find_by_id(params.fetch(:todo_list_id))
    if @todo_list.nil?
      flash[:alert] = 'You are not the owner of that list or the list does not exist.'
      redirect_to root_path
    end
  end

  def todo_item_params
    Time.zone = 'America/New_York'
    params.require(:todo_item).permit(:name, :due_at)
  end
end
