require 'rails_helper'

RSpec.describe TodoItemsController, type: :controller do
  describe 'POST #create' do
    context 'with valid params' do
      it 'renders the parent todo list with success message' do
        @todo_list = create(:todo_list)

        post :create, todo_list_id: @todo_list, todo_item: attributes_for(:todo_item), todo_list: @todo_list

        expect(flash[:notice]).to match(/^Item successfully added./)
        expect(response).to redirect_to @todo_list
      end
    end

    context 'with invalid params' do
      it 'renders the parent todo list with errors' do
        @todo_list = create(:todo_list)

        post :create, todo_list_id: @todo_list, todo_item: attributes_for(:todo_item, name: '')

        expect(flash[:error]).to match(/^Error adding item./)
        expect(response).to redirect_to @todo_list
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'with a valid item' do
      it 'destroys the item and flashes success' do
        @todo_list = create(:todo_list_with_items, items_count: 5)
        @todo_item = @todo_list.todo_items.first

        delete :destroy, id: @todo_item, todo_list_id: @todo_list

        expect(flash[:notice]).to match(/^Item successfully deleted./)
      end
    end
  end
end
