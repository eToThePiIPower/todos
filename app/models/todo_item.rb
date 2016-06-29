class TodoItem < ActiveRecord::Base
  belongs_to :todo_list
  delegate :user, to: :todo_list

  validates :todo_list, presence: true

  validates :name, presence: true
  validates :name, length: { minimum: 3 }

  def complete!
    self[:completed_at] = Time.current unless complete?
  end

  def uncomplete!
    self[:completed_at] = nil
  end

  def complete?
    !self[:completed_at].nil? && self[:completed_at] < Time.current
  end
end
