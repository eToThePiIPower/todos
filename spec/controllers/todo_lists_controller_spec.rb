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

        put :update, id: @todo_list, todo_list: { name: 'New Name' }

        expect(response).to redirect_to @todo_list
        expect(flash[:notice]).to match(/^Todo List successfully updated./)
      end
    end

    context 'with invalid params' do
      it 'renders the form with errors' do
        @todo_list = create(:todo_list)

        put :update, id: @todo_list, todo_list: { name: '' }

        expect(response).to render_template :edit
        expect(flash[:error]).to match(/^Validation errors./)
      end
    end
  end

  describe 'GET #show' do
    it 'assigns the list and an array of its items' do
      @todo_list = create(:todo_list_with_items)
      @todo_items = @todo_list.todo_items

      get :show, id: @todo_list

      expect(assigns(:todo_list)).to eq @todo_list
      expect(assigns(:todo_items)).to eq @todo_items
    end
  end

  describe 'GET #index' do
    it 'retrieves all of the todo lists' do
      3.times { create(:todo_list) }

      get :index

      expect(response).to render_template :index
      expect(assigns(:todo_lists).length).to be(3)
      expect(assigns(:todo_lists).first).to eq(TodoList.first)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the todo list' do
      @todo_list = create(:todo_list)

      expect do
        delete :destroy, id: @todo_list
      end.to change(TodoList, :count).by(-1)
    end

    it 'redirects to the index' do
      @todo_list = create(:todo_list)

      delete :destroy, id: @todo_list

      expect(response).to redirect_to :todo_lists
    end
  end
end
