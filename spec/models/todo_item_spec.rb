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

  describe 'uncomplete' do
    it 'sets the completed_at date to nil' do
      @todo_item = build(:todo_item, :complete)

      @todo_item.uncomplete!

      expect(@todo_item.completed_at).to be_nil
    end
  end

  # Time methods
  describe '.due_at_in_user_zone' do
    it 'when the due date is set' do
      @due_datetime = 1.day.from_now
      @todo_item = build(:todo_item, due_at: @due_datetime)

      expect(@todo_item.due_at_in_user_zone).to eq @due_datetime.in_time_zone('America/New_York').strftime('%Y-%m-%dT%H:%M')
    end

    it 'when the due date is nil' do
      @todo_item = build(:todo_item)

      expect(@todo_item.due_at_in_user_zone).to be nil
    end
  end

  describe '.due_now?' do
    it 'returns false if the item is complete' do
      @todo_item = build(:todo_item, completed_at: 1.day.ago, due_at: 1.hour.from_now)

      expect(@todo_item.due_now?).to be false
    end

    it 'returns false if the due_at date is more than 1 day in the future' do
      @todo_item = build(:todo_item, due_at: 2.days.from_now)

      expect(@todo_item.due_now?).to be false
    end

    it 'returns false if there is no due_at date' do
      @todo_item = build(:todo_item)

      expect(@todo_item.due_now?).to be false
    end

    it 'returns false if the item is overdue' do
      @todo_item = build(:todo_item, due_at: 1.hour.ago)

      expect(@todo_item.due_now?).to be false
    end

    it 'returns true if the item is not not complete and the due_at date is in the past' do
      @todo_item = build(:todo_item, due_at: 1.hour.from_now)

      expect(@todo_item.due_now?).to be true
    end
  end

  describe '.overdue?' do
    it 'returns false if complete? and due_at is in the past' do
      @todo_item = build(:todo_item, completed_at: 1.day.ago, due_at: 2.days.ago)

      expect(@todo_item.overdue?).to be false
    end

    it 'returns false if not complete? and due_at? is nil' do
      @todo_item = build(:todo_item, completed_at: nil, due_at: nil)

      expect(@todo_item.overdue?).to be false
    end

    it 'returns true if not complete? and due_at is in the past' do
      @todo_item = build(:todo_item, completed_at: nil, due_at: 2.days.ago)

      expect(@todo_item.overdue?).to be true
    end

    it 'returns false if not complete? and due_at is in the future' do
      @todo_item = build(:todo_item, completed_at: nil, due_at: 2.days.from_now)

      expect(@todo_item.overdue?).to be false
    end
  end

  describe '.archived?' do
    it 'returns true if completed_at is more than 1 week ago' do
      @todo_item = build(:todo_item, completed_at: 8.days.ago)

      expect(@todo_item).to be_archived
    end

    it 'returns false if completed_at is less than 1 week ago' do
      @todo_item = build(:todo_item, completed_at: 6.days.ago)

      expect(@todo_item).not_to be_archived
    end

    it 'returns false if completed_at is nil' do
      @todo_item = build(:todo_item)

      expect(@todo_item).not_to be_archived
    end
  end

  # Sort order functions

  describe 'sort_order' do
    context 'there is no due date' do
      before do
        @todo_item = build(:todo_item)
      end

      it 'returns with prefix 0' do
        expect(@todo_item.sort_order).to match(/^0:/)
      end

      it 'returns with postfix 7.days.from_now in UTC in iso8601 form' do
        expect(@todo_item.sort_order).to match(/:#{7.days.from_now.in_time_zone('UTC').iso8601}/)
      end
    end

    context 'the item is incomplete' do
      before do
        @todo_item = build(:todo_item, due_at: 1.day.from_now)
      end

      it 'returns with prefix 0' do
        expect(@todo_item.sort_order).to match(/^0:/)
      end

      it 'returns with postfix due_at in UTC in iso8601 form' do
        expect(@todo_item.sort_order).to match(/:#{@todo_item.due_at.in_time_zone('UTC').iso8601}/)
      end
    end

    context 'the item is complete' do
      before do
        @todo_item = build(:todo_item, completed_at: 1.day.ago)
      end

      it 'returns with prefix 1' do
        expect(@todo_item.sort_order).to match(/^1:/)
      end

      # pending 'returns with the postfix seconds since completion' do
      #   # Awaiting timecop
      #   expect(@todo_item.sort_order).to match(/:#{Time.current - 1.day.ago}/)
      # end
    end
  end

  # Content generators

  describe '.tag_for_time' do
    it 'returns a time.timeago element' do
      @todo_item = build(:todo_item, due_at: 1.day.from_now)

      expect(@todo_item.tag_for_time(:due)).to match '<span>Due </span>'
      expect(@todo_item.tag_for_time(:due)).to match '<time '
      expect(@todo_item.tag_for_time(:due)).to match 'class="timeago"'
      expect(@todo_item.tag_for_time(:due)).to match @todo_item.due_at.strftime('%A, %B %e %Y @%l:%M%P %Z')
      expect(@todo_item.tag_for_time(:due)).to match "datetime=\"#{@todo_item.due_at.iso8601}\""
      expect(@todo_item.tag_for_time(:due)).to match "shorttime=\"#{@todo_item.due_at.strftime('%c %Z')}\""
    end

    it 'returns a default value if the time field is not set' do
      @todo_item = build(:todo_item)

      expect(@todo_item.tag_for_time(:due)).to match '<span>No due time set</span>'
    end
  end
end
