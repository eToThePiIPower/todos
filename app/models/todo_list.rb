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
    if total.equal?(0)
      0
    else
      (100.0 * todo_items.where('completed_at < ?', Time.current).size / total).to_int
    end
  end

  # Helpers
  def progress_bar_type
    if percent_complete < 25
      'progress-bar-danger'
    elsif percent_complete < 50
      'progress-bar-warning'
    elsif percent_complete < 75
      'progress-bar-success'
    elsif percent_complete < 100
      'progress-bar-info'
    else
      'progress-bar-info progress-bar-striped active'
    end
  end
end
