require 'rails_helper'

RSpec.describe 'todo_lists/index.html.slim' do
  context 'when there are no todo lists' do
    context 'when a user is logged in' do
      it 'encourages the user to create a todo list' do
        allow(view).to receive(:current_user).and_return(build(:user))
        assign(:todo_lists, [])

        render

        expect(rendered).to have_css("a.btn-primary[href='#{new_todo_list_path}']", text: 'Create Todo List')
      end
    end
  end
end
