require 'rails_helper'

RSpec.describe TodoListsController, type: :controller do
  describe 'POST #create' do
    context 'with valid params' do
      before do
        post :create, todo_list: { name: 'Valid Name', description: 'Valid' }
      end

      it { is_expected.to redirect_to TodoList.last }
    end

    context 'with invalid params' do
      before do
        post :create, todo_list: { name: '', description: 'Valid' }
      end

      it { is_expected.to render_template :new }
    end
  end

  describe 'POST #update' do
    context 'with valid params' do
      before do
        @todo_list = TodoList.create(name: 'Original Name', description: 'Original Description')
        put :update, id: @todo_list.id, todo_list: { name: 'New Name', description: 'Valid' }
      end

      it { is_expected.to redirect_to @todo_list }
    end

    context 'with invalid params' do
      before do
        @todo_list = TodoList.create(name: 'Original Name', description: 'Original Description')
        put :update, id: @todo_list.id, todo_list: { name: '', description: 'Valid' }
      end

      it { is_expected.to render_template :edit }
    end
  end
end
