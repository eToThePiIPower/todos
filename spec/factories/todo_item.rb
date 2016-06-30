FactoryGirl.define do
  factory :todo_item do
    todo_list

    name 'Do Something Awesome'

    trait :complete do
      completed_at 1.minute.ago
    end

    trait :old do
      completed_at 1.month.ago
    end
  end
end
