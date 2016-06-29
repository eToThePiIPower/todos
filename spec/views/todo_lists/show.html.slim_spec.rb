require 'rails_helper'

RSpec.describe 'todo_lists/show.html.slim' do
  before do
    stub_template 'todo_items/_form.html.slim' => 'add item form goes here'
    stub_template 'todo_items/_show.html.slim' => 'item description goes here'
  end

  context 'when there are todo items' do
    it 'highlights completed todo items' do
      @todo_list = create(:todo_list_with_items, items_count: 10, completed_items_count: 3)
      assign(:todo_list, @todo_list)
      assign(:todo_items, @todo_list.todo_items)

      render

      expect(rendered).to have_css('li.todo-list-item-complete', count: 3)
      expect(rendered).to have_css('li.todo-list-item-incomplete', count: 7)
    end
  end
end
