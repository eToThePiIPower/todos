require 'rails_helper'

RSpec.describe TodoItem, type: :model do
  it { should belong_to :todo_list }
  it { should validate_presence_of :todo_list }

  it { should delegate_method(:user).to(:todo_list) }

  it { should validate_presence_of :name }
  it { should validate_length_of(:name).is_at_least(3) }

  describe 'complete!' do
    it 'sets the completed_at date' do
      @todo_item = build(:todo_item)

      @todo_item.complete!

      expect(@todo_item.completed_at).to be_within(5.seconds).of(Time.current)
    end

    it 'does not change the completed_at date of complete items' do
      @todo_item = build(:todo_item, completed_at: 2.years.ago)

      @todo_item.complete!

      expect(@todo_item.completed_at).to be_within(1.day).of(2.years.ago)
    end
  end

  describe 'complete?' do
    it 'returns true if completed_at is in the past' do
      @todo_item = build(:todo_item, completed_at: 1.year.ago)

      expect(@todo_item).to be_complete
    end

    it 'returns false if completed_at is nil' do
      @todo_item = build(:todo_item)

      expect(@todo_item).not_to be_complete
    end

    it 'returns false if completed_at is in the future' do
      @todo_item = build(:todo_item, completed_at: 1.year.from_now)

      expect(@todo_item).not_to be_complete
    end
  end

  describe 'old?' do
    it 'returns true if completed_at is more than 1 week ago' do
      @todo_item = build(:todo_item, completed_at: 8.days.ago)

      expect(@todo_item).to be_old
    end

    it 'returns false if completed_at is less than 1 week ago' do
      @todo_item = build(:todo_item, completed_at: 6.days.ago)

      expect(@todo_item).not_to be_old
    end

    it 'returns false if completed_at is nil' do
      @todo_item = build(:todo_item)

      expect(@todo_item).not_to be_old
    end
  end

  describe 'uncomplete' do
    it 'sets the completed_at date to nil' do
      @todo_item = build(:todo_item, :complete)

      @todo_item.uncomplete!

      expect(@todo_item.completed_at).to be_nil
    end
  end
end
