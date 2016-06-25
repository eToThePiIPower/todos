class TodoItemsController < ApplicationController
  def create
    @todo_list = TodoList.find(params[:todo_list_id])
    @todo_item = @todo_list.todo_items.new(todo_item_params)

    if @todo_item.save
      flash[:notice] = 'Item successfully added.'
    else
      flash[:error] = 'Error adding item.'
    end
    redirect_to @todo_list
  end
end

private

def todo_item_params
  params.require(:todo_item).permit(:name)
end
