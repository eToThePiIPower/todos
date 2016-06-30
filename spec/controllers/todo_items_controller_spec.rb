require 'rails_helper'

RSpec.describe TodoItemsController, type: :controller do
  before(:all) do
    @owner = create(:user)
    @other_user = create(:user)
    @todo_list = create(:todo_list, user: @owner)
  end
  after(:all) do
    @todo_list.destroy
    @other_user.destroy
    @owner.destroy
  end

  describe 'POST #create' do
    context 'when the user owns the list' do
      before do
        sign_in @owner
      end

      context 'with valid params' do
        it 'renders the parent todo list with success message' do
          expect do
            post :create, todo_item: attributes_for(:todo_item),
                          todo_list_id: @todo_list
          end.to change(TodoItem, :count).by(1)

          expect(flash[:notice]).to match(/^Item successfully added./)
          expect(response).to redirect_to @todo_list
        end
      end

      context 'with invalid params' do
        it 'renders the parent todo list with errors' do
          expect do
            post :create, todo_item: attributes_for(:todo_item, name: ''),
                          todo_list_id: @todo_list
          end.not_to change(TodoItem, :count)

          expect(flash[:error]).to match(/^Error adding item./)
          expect(response).to redirect_to @todo_list
        end
      end
    end

    context 'when the user does not own the list' do
      it 'does nothing and returns an error' do
        sign_in @other_user

        expect do
          post :create, todo_list_id: @todo_list,
                        todo_item: attributes_for(:todo_item)
        end.not_to change(TodoItem, :count)

        expect_it_to_return_an_authorization_error
      end
    end

    context 'when the user is not signed in' do
      it 'does nothing and returns an error' do
        expect do
          post :create, todo_list_id: @todo_list,
                        todo_item: attributes_for(:todo_item)
        end.not_to change(TodoItem, :count)

        expect_it_to_require_the_user_be_signed_in
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      @todo_item = create(:todo_item, todo_list: @todo_list)
    end

    context 'when the user owns the containing list' do
      it 'destroys the item and flashes success' do
        sign_in @owner

        expect do
          delete :destroy, id: @todo_item, todo_list_id: @todo_list
        end.to change(TodoItem, :count).by(-1)

        expect(flash[:notice]).to match(/^Item successfully deleted./)
      end
    end

    context 'when the user does not own the containing list' do
      it 'does nothing and returns an error' do
        sign_in @other_user

        expect do
          delete :destroy, id: @todo_item, todo_list_id: @todo_list
        end.not_to change(TodoItem, :count)

        expect_it_to_return_an_authorization_error
      end
    end

    context 'when the user is not logged in' do
      it 'does nothing and returns an error' do
        expect do
          delete :destroy, id: @todo_item, todo_list_id: @todo_list
        end.not_to change(TodoItem, :count)

        expect_it_to_require_the_user_be_signed_in
      end
    end
  end

  context 'PUT #complete' do
    before do
      @todo_item = create(:todo_item, todo_list: @todo_list)
    end

    context 'when the user owns the containing list' do
      it 'marks the item as complete' do
        sign_in @owner

        put :complete, id: @todo_item, todo_list_id: @todo_list
        @todo_item.reload

        expect(@todo_item).to be_complete
      end
    end

    context 'when the user does not own the containing list' do
      it 'does not mark the item as complete' do
        sign_in @other_user

        put :complete, id: @todo_item, todo_list_id: @todo_list
        @todo_item.reload

        expect(@todo_item).not_to be_complete
        expect_it_to_return_an_authorization_error
      end
    end

    context 'when the user is not logged in' do
      it 'does not mark the item as complete' do
        put :complete, id: @todo_item, todo_list_id: @todo_list
        @todo_item.reload

        expect(@todo_item).not_to be_complete
        expect_it_to_require_the_user_be_signed_in
      end
    end
  end

  context 'PUT #uncomplete' do
    before do
      @todo_item = create(:todo_item, :complete, todo_list: @todo_list)
    end

    context 'when the user owns the containing list' do
      it 'unmarks the item as complete' do
        sign_in @owner

        delete :uncomplete, id: @todo_item, todo_list_id: @todo_list
        @todo_item.reload

        expect(@todo_item).not_to be_complete
      end
    end

    context 'when the user does not own the containing list' do
      it 'does not unmark the item as complete' do
        sign_in @other_user

        delete :uncomplete, id: @todo_item, todo_list_id: @todo_list
        @todo_item.reload

        expect(@todo_item).to be_complete
        expect_it_to_return_an_authorization_error
      end
    end

    context 'when the user is not logged in' do
      it 'does not unmark the item as complete' do
        delete :uncomplete, id: @todo_item, todo_list_id: @todo_list
        @todo_item.reload

        expect(@todo_item).to be_complete
        expect_it_to_require_the_user_be_signed_in
      end
    end
  end
end
