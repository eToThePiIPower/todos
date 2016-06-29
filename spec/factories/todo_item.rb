FactoryGirl.define do
  factory :todo_item do
    todo_list

    name 'Do Something Awesome'

    factory :completed_todo_item do
      completed_at 1.minute.ago
    end
  end
end
