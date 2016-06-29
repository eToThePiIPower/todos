require 'rails_helper'

RSpec.describe 'todo_lists/index.html.slim' do
  context 'when there are no todo lists' do
    context 'when a user is logged in' do
      it 'encourages the user to create a todo list' do
        view.stub(:current_user) { build(:user) }
        assign(:todo_lists, [])

        render

        expect(rendered).to have_selector("a[href='#{new_todo_list_path}']", 'Create Todo List')
      end
    end
  end
end
