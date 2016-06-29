FactoryGirl.define do
  factory :todo_list do
    name 'Valid List'
    description 'Valid Description'

    factory :todo_list_with_uncompleted_items do
      transient do
        items_count 5
      end

      after(:create) do |list, evaluator|
        create_list(:todo_item, evaluator.items_count, todo_list: list)
      end
    end

    factory :todo_list_with_completed_items do
      transient do
        items_count 5
      end

      after(:create) do |list, evaluator|
        create_list(:completed_todo_item, evaluator.items_count, todo_list: list)
      end
    end

    factory :todo_list_with_items do
      transient do
        items_count 5
        completed_items_count 0
      end

      after(:create) do |list, evaluator|
        create_list(:todo_item, (evaluator.items_count - evaluator.completed_items_count), todo_list: list)
        create_list(:completed_todo_item, evaluator.completed_items_count, todo_list: list)
      end
    end
  end

  factory :invalid_todo_list, class: TodoList do
    name ''
    description ''
  end
end
