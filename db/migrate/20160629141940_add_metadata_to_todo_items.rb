class AddMetadataToTodoItems < ActiveRecord::Migration
  def change
    add_column :todo_items, :completed_at, :datetime
    add_column :todo_items, :due_at, :datetime
  end
end
