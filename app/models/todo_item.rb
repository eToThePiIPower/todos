class TodoItem < ActiveRecord::Base
  belongs_to :todo_list
  delegate :user, to: :todo_list

  validates :todo_list, presence: true

  validates :name, presence: true
  validates :name, length: { minimum: 3 }

  default_scope { order(created_at: :desc) }

  def complete!
    self[:completed_at] = Time.current unless complete?
  end

  def complete?
    !self[:completed_at].nil? && self[:completed_at] < Time.current
  end

  def old?
    !self[:completed_at].nil? && self[:completed_at] < 1.week.ago
  end

  def uncomplete!
    self[:completed_at] = nil
  end
end
