require 'rails_helper'

RSpec.describe TodoItem, type: :model do
  it { should belong_to :todo_list }
  it { should validate_presence_of :todo_list }

  it { should delegate_method(:user).to(:todo_list) }

  it { should validate_presence_of :name }
  it { should validate_length_of(:name).is_at_least(3) }
end
