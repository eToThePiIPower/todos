require 'rails_helper'

RSpec.describe TodoList, type: :model do
  it { should validate_presence_of :name }
  it { should validate_length_of(:name).is_at_least(3).is_at_most(32) }

  it { should validate_presence_of :description }
  it { should validate_length_of(:description).is_at_least(3).is_at_most(140) }
end
