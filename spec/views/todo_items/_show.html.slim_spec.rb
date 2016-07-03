require 'rails_helper'

RSpec.describe 'todo_items/_show.html.slim' do
  before do
    allow(view).to receive(:todo_list_complete_path).and_return('complete link')
    allow(view).to receive(:todo_list_uncomplete_path).and_return('uncomplete link')
    allow(view).to receive(:todo_list_todo_item_path).and_return('deletion link')
    stub_template 'todo_items/_modal_form.html.slim' => 'add item form goes here'
  end
  context 'when the item is complete' do
    it 'has an uncomplete button' do
      @todo_item = build(:todo_item, :complete)
      @completed_at = @todo_item.completed_at

      render 'todo_items/show', item: @todo_item

      expect(rendered).not_to have_css("a.btn-xs[href='complete link']", text: 'Complete this item')
      expect(rendered).to have_css("a.btn-xs[href='uncomplete link']", text: 'Uncomplete this item')
      expect(rendered).to have_css("time.timeago[datetime='#{@completed_at.iso8601}']")
    end
  end

  context 'when the item is not complete' do
    it 'has an complete button' do
      @todo_item = build(:todo_item)
      allow(@todo_item).to receive(:tag_for_time).with(:created).and_return('born yesterday')
      allow(@todo_item).to receive(:tag_for_time).with(:due).and_return('due last week')

      render 'todo_items/show', item: @todo_item

      expect(rendered).to have_css("a.btn-xs[href='complete link']", text: 'Complete this item')
      expect(rendered).not_to have_css("a.btn-xs[href='uncomplete link']", text: 'Uncomplete this item')
      expect(rendered).to have_content 'born yesterday'
      expect(rendered).to have_content 'due last week'
    end
  end
end
