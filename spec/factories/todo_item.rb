FactoryGirl.define do
  factory :todo_item do
    todo_list

    name 'Do Something Awesome'

    trait :complete do
      completed_at 1.minute.ago
    end

    trait :due_yesterday do
      due_at 1.day.ago
    end

    trait :due_tomorrow do
      due_at 1.day.from_now
    end

    trait :old do
      completed_at 1.month.ago
    end
  end
end
