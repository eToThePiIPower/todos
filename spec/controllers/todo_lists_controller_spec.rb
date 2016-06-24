require 'rails_helper'

RSpec.describe TodoListsController, type: :controller do
  describe 'POST #create' do
    context 'with valid params' do
      it 'redirects to the newly created todo list' do
        post :create, todo_list: { name: 'Valid Name', description: 'Valid' }

        expect(response).to redirect_to TodoList.last
        expect(flash[:notice]).to match(/^Todo List successfully created./)
      end
    end

    context 'with invalid params' do
      it 'renders the form with errors' do
        post :create, todo_list: { name: '', description: 'Valid' }

        expect(response).to render_template :new
        expect(flash[:error]).to match(/^Validation errors./)
      end
    end
  end

  describe 'POST #update' do
    context 'with valid params' do
      it 'redirects to the newly updated todo list' do
        @todo_list = TodoList.create(name: 'Original Name', description: 'Original Description')

        put :update, id: @todo_list.id, todo_list: { name: 'Valid Name', description: 'Valid' }

        expect(response).to redirect_to @todo_list
        expect(flash[:notice]).to match(/^Todo List successfully updated./)
      end
    end

    context 'with invalid params' do
      it 'renders the form with errors' do
        @todo_list = TodoList.create(name: 'Original Name', description: 'Original Description')

        put :update, id: @todo_list.id, todo_list: { name: '', description: 'Valid' }

        expect(response).to render_template :edit
        expect(flash[:error]).to match(/^Validation errors./)
      end
    end
  end
end
