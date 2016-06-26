class TodoList < ActiveRecord::Base
  has_many :todo_items

  validates :name, presence: true
  validates :name, length: { minimum: 3, maximum: 32 }

  validates :description, presence: true
  validates :description, length: { minimum: 3, maximum: 140 }
end
