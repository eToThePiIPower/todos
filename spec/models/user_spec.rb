require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many :todo_lists }
  it { should have_many(:todo_items).through(:todo_lists) }
end
