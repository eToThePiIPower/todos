class AddDefaultDueAtDurationToTodoLists < ActiveRecord::Migration
  def change
    add_column :todo_lists, :default_due_at_duration, :integer
  end
end
