include ActionView::Helpers::TagHelper

class TodoItem < ActiveRecord::Base
  belongs_to :todo_list
  delegate :user, to: :todo_list

  validates :todo_list, presence: true

  validates :name, presence: true
  validates :name, length: { minimum: 3 }

  validates :description, length: { maximum: 1024 }

  scope :active, lambda {
    where('completed_at IS NULL OR completed_at >= ?', 7.days.ago)
  }

  scope :archived, lambda {
    where('completed_at < ?', 7.days.ago)
  }

  scope :priority, lambda {
    order("
      CASE WHEN completed_at IS NULL AND due_at < CURRENT_DATE + INTERVAL '7 days' THEN (1, due_at) END ASC,
      CASE WHEN completed_at IS NULL AND due_at IS NULL THEN (2, due_at) END ASC,
      CASE WHEN completed_at IS NULL THEN (3, due_at) END ASC,
      CASE WHEN completed_at IS NOT NULL THEN (5, completed_at) END DESC
    ")
  }

  # Completion methods

  def complete!
    self[:completed_at] = Time.current unless complete?
  end

  def complete?
    !self[:completed_at].nil? && self[:completed_at] < Time.current
  end

  def uncomplete!
    self[:completed_at] = nil
  end

  # Time methods

  def overdue?
    self[:completed_at].nil? && !self[:due_at].nil? && self[:due_at] < Time.current
  end

  def due_now?
    !complete? && !overdue? && !self[:due_at].nil? && self[:due_at] < 1.day.from_now
  end

  def archived?
    !self[:completed_at].nil? && self[:completed_at] < 1.week.ago
  end

  def due_at_in_user_zone
    unless due_at.nil?
      due_at.in_time_zone('America/New_York').strftime('%Y-%m-%dT%H:%M')
    end
  end

  # Sorting functions
  def sort_order
    # Added to data-attributes to sort via jQuery
    if complete?
      "1:#{Time.current - completed_at}"
    elsif due_at.nil?
      "0:#{7.days.from_now.in_time_zone('UTC').iso8601}"
    else
      "0:#{due_at.in_time_zone('UTC').iso8601}"
    end
  end

  # Tag content

  def tag_for_time(time_field)
    value = self[:"#{time_field}_at"]
    if value.nil?
      content_tag(:span, "No #{time_field} time set")
    else
      content_tag(:span, "#{time_field.capitalize} ") +
        content_tag(:time, value.strftime('%A, %B %e %Y @%l:%M%P %Z'),
                    class: 'timeago',
                    datetime: value.iso8601,
                    shorttime: value.strftime('%c %Z'))
    end
  end
end
