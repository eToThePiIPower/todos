FactoryGirl.define do
  factory :todo_list do
    name 'Valid List'
    description 'Valid Description'

    factory :todo_list_with_items do
      transient do
        items_count 5
        completed_items_count 0
        old_items_count 0
      end

      todo_items do
        build_list(:todo_item, items_count - completed_items_count - old_items_count) +
          build_list(:todo_item, completed_items_count, :complete) +
          build_list(:todo_item, old_items_count, :old)
      end
    end
  end

  factory :invalid_todo_list, class: TodoList do
    name ''
    description ''
  end
end
