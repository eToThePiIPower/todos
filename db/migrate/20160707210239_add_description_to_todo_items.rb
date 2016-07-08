class AddDescriptionToTodoItems < ActiveRecord::Migration
  def change
    add_column :todo_items, :description, :text
  end
end
