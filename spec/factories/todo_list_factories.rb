FactoryGirl.define do
  factory :todo_list do
    name 'Valid List'
    description 'Valid Description'
  end

  factory :invalid_todo_list, class: TodoList do
    name ''
    description ''
  end
end
