class CreateTodoLists < ActiveRecord::Migration
  def change
    create_table :todo_lists do |t|
      t.string :name
      t.string :description

      t.timestamps null: false
    end
  end
end
