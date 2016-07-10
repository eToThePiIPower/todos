require 'rails_helper'

RSpec.describe 'todo_lists/show.html.slim' do
  before do
    stub_template 'todo_items/_form.html.slim' => 'add item form goes here'
    # stub_template 'todo_items/_show.html.slim' => 'item description goes here'
    stub_template 'todo_items/_modal_form.html.slim' => 'add item form goes here'

    allow(view).to receive(:todo_list_complete_path).and_return('complete link')
    allow(view).to receive(:todo_list_uncomplete_path).and_return('uncomplete link')
    allow(view).to receive(:todo_list_todo_item_path).and_return('deletion link')
  end

  context 'when there are todo items' do
    it 'highlights completed todo items' do
      @todo_list = build(:todo_list_with_items, items_count: 10, completed_items_count: 3)
      assign(:todo_list, @todo_list)
      assign(:todo_items, @todo_list.todo_items)

      render

      expect(rendered).to have_css('li.todo-list-item-complete', count: 3)
      expect(rendered).to have_css('li.todo-list-item-incomplete', count: 7)
    end

    it 'mutes archived todo items' do
      @todo_list = build(:todo_list_with_items, items_count: 10, old_items_count: 3)
      assign(:todo_list, @todo_list)
      assign(:todo_items, @todo_list.todo_items)

      render

      expect(rendered).to have_css('li.todo-list-item-complete.todo-list-item-archived', count: 3)
      expect(rendered).to have_css('li.todo-list-item-incomplete', count: 7)
    end

    it 'flags overdue todo items' do
      @todo_list = build(:todo_list_with_items, items_count: 10)
      @todo_items = @todo_list.todo_items
      @todo_items[0..2].each { |i| i.due_at = 1.day.ago }
      assign(:todo_list, @todo_list)
      assign(:todo_items, @todo_items)

      render

      expect(rendered).to have_css('li.todo-list-item-overdue', count: 3)
      expect(rendered).to have_css('li.todo-list-item-incomplete', count: 10)
    end
  end
end
