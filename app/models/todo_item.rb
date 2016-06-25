class TodoItem < ActiveRecord::Base
  belongs_to :todo_list

  validates :todo_list, presence: true

  validates :name, presence: true
  validates :name, length: { minimum: 3 }
end
