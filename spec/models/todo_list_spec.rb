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

  describe '.percent_complete' do
    it 'returns 0 if there are no items' do
      @todo_list = build(:todo_list)

      expect(@todo_list.percent_complete).to be 0
    end

    it 'returns an integer of percent (out of 100%) complete' do
      @todo_list = create(:todo_list_with_items, items_count: 100, completed_items_count: 20)

      expect(@todo_list.percent_complete).to be 20
    end
  end

  describe '.data_confirm' do
    it 'returns nil if there are no items' do
      @todo_list = build(:todo_list)

      expect(@todo_list.data_confirm).to be nil
    end

    it 'returns a hash for a data-confirm dialog if there are items' do
      @todo_list = build(:todo_list_with_items, items_count: 5)

      @expected = {
        confirm: "Delete the todo list <em>#{@todo_list.name}</em>? This list has #{@todo_list.items} items!",
        commit: 'Delete!',
        verify: @todo_list.name,
        verify_text: "Type \"#{@todo_list.name}\" ",
      }

      expect(@todo_list.data_confirm).to eq @expected
    end
  end

  describe '.progress_bar_type' do
    it 'returns progress-bar-danger when percent_complete < 25' do
      @todo_list = build(:todo_list)
      allow(@todo_list).to receive(:percent_complete).and_return(24)

      expect(@todo_list.progress_bar_type).to eq 'progress-bar-danger'
    end

    it 'returns progress-bar-warning when percent_complete < 50' do
      @todo_list = build(:todo_list)
      allow(@todo_list).to receive(:percent_complete).and_return(25)

      expect(@todo_list.progress_bar_type).to eq 'progress-bar-warning'
    end

    it 'returns progress-bar-warning when percent_complete < 50' do
      @todo_list = build(:todo_list)
      allow(@todo_list).to receive(:percent_complete).and_return(49)

      expect(@todo_list.progress_bar_type).to eq 'progress-bar-warning'
    end

    it 'returns progress-bar-success when percent_complete < 75' do
      @todo_list = build(:todo_list)
      allow(@todo_list).to receive(:percent_complete).and_return(50)

      expect(@todo_list.progress_bar_type).to eq 'progress-bar-success'
    end

    it 'returns progress-bar-success when percent_complete < 75' do
      @todo_list = build(:todo_list)
      allow(@todo_list).to receive(:percent_complete).and_return(74)

      expect(@todo_list.progress_bar_type).to eq 'progress-bar-success'
    end

    it 'returns progress-bar-info when percent_complete < 100' do
      @todo_list = build(:todo_list)
      allow(@todo_list).to receive(:percent_complete).and_return(75)

      expect(@todo_list.progress_bar_type).to eq 'progress-bar-info'
    end

    it 'returns progress-bar-info when percent_complete < 100' do
      @todo_list = build(:todo_list)
      allow(@todo_list).to receive(:percent_complete).and_return(99)

      expect(@todo_list.progress_bar_type).to eq 'progress-bar-info'
    end

    it 'returns progress-bar-info.active when percent_complete == 100' do
      @todo_list = build(:todo_list)
      allow(@todo_list).to receive(:percent_complete).and_return(100)

      expect(@todo_list.progress_bar_type).to eq 'progress-bar-info progress-bar-striped active'
    end
  end
end
