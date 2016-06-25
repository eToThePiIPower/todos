FactoryGirl.define do
  factory :todo_list do
    name 'Valid List'
    description 'Valid Description'

    factory :todo_list_with_items do
      transient do
        items_count 5
      end

      after(:create) do |list, evaluator|
        create_list(:todo_item, evaluator.items_count, todo_list: list)
      end
    end
  end

  factory :invalid_todo_list, class: TodoList do
    name ''
    description ''
  end
end
