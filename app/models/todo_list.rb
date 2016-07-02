class TodoList < ActiveRecord::Base
  has_many :todo_items, dependent: :destroy
  belongs_to :user

  validates :name, presence: true
  validates :name, length: { minimum: 3, maximum: 32 }

  validates :description, presence: true
  validates :description, length: { minimum: 3, maximum: 140 }

  def data_confirm
    if items?
      count = ActionController::Base.helpers.pluralize(items, 'item')
      { confirm: "Delete the todo list <em>#{name}</em>? This list has #{count}!",
        commit: 'Delete!',
        verify: name,
        verify_text: "Type \"#{name}\" " }
    end
  end

  def items?
    !todo_items.empty?
  end

  def items
    todo_items.size
  end

  def percent_complete
    total = todo_items.count
    if total == 0
      0
    else
      100.0 * todo_items.where('completed_at < ?', Time.current).count / total
    end
  end
end
