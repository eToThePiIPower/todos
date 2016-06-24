require 'rails_helper'

RSpec.describe TodoListsController, type: :controller do
  describe 'POST #create' do
    context 'with valid params' do
      it 'redirects to the newly created todo list' do
        post :create, todo_list: attributes_for(:todo_list)

        expect(response).to redirect_to TodoList.last
        expect(flash[:notice]).to match(/^Todo List successfully created./)
      end
    end

    context 'with invalid params' do
      it 'renders the form with errors' do
        post :create, todo_list: attributes_for(:invalid_todo_list)

        expect(response).to render_template :new
        expect(flash[:error]).to match(/^Validation errors./)
      end
    end
  end

  describe 'POST #update' do
    context 'with valid params' do
      it 'redirects to the newly updated todo list' do
        @todo_list = create(:todo_list)

        put :update, id: @todo_list.id, todo_list: { name: 'New Name' }

        expect(response).to redirect_to @todo_list
        expect(flash[:notice]).to match(/^Todo List successfully updated./)
      end
    end

    context 'with invalid params' do
      it 'renders the form with errors' do
        @todo_list = create(:todo_list)

        put :update, id: @todo_list.id, todo_list: { name: '' }

        expect(response).to render_template :edit
        expect(flash[:error]).to match(/^Validation errors./)
      end
    end
  end
end
