require 'rails_helper'

RSpec.describe TodoList, type: :model do
  it { should have_many :todo_items }
  it { should belong_to :user }

  it { should validate_presence_of :name }
  it { should validate_length_of(:name).is_at_least(3).is_at_most(32) }

  it { should validate_presence_of :description }
  it { should validate_length_of(:description).is_at_least(3).is_at_most(140) }

  describe '#items?' do
    it 'returns false if there are no items' do
      @todo_list = build(:todo_list)

      expect(@todo_list.items?).to be_falsy
    end

    it 'returns true if there are items' do
      @todo_list = build(:todo_list_with_items)

      expect(@todo_list.items?).to be_truthy
    end
  end

  describe '#items' do
    it 'returns 0 if there are no items' do
      @todo_list = build(:todo_list)

      expect(@todo_list.items).to eq(0)
    end

    it 'returns the count of items' do
      @todo_list = build(:todo_list_with_items, items_count: 5)

      expect(@todo_list.items).to eq(5)
    end
  end
end
