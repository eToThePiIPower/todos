require 'rails_helper'

RSpec.describe TodoListsController, type: :controller do
  describe 'POST #create' do
    context 'when a user is logged in' do
      before do
        @user = create(:user)
        sign_in @user
      end

      context 'with valid params' do
        it 'redirects to the newly created todo list' do
          @todo_list = attributes_for(:todo_list)

          post :create, todo_list: @todo_list

          expect(response).to redirect_to TodoList.last
          expect(flash[:notice]).to match(/^Todo List successfully created./)
          expect(TodoList.last).to belong_to_user @user
        end
      end

      context 'with invalid params' do
        it 'renders the form with errors when' do
          @todo_list = attributes_for(:invalid_todo_list)

          post :create, todo_list: @todo_list

          expect(response).to render_template :new
          expect(flash[:error]).to match(/^Validation errors./)
        end
      end
    end

    context 'when no user is logged in' do
      it 'redirects to the log in form' do
        post :create, todo_list: attributes_for(:todo_list)

        expect(response).to redirect_to new_user_session_path
        expect(flash[:alert]).to match(/^You need to sign in or sign up./)
      end
    end
  end

  describe 'POST #update' do
    context 'when the owner is logged in' do
      before do
        @user = create(:user)
        @todo_list = @user.todo_lists.create(attributes_for(:todo_list))
        sign_in @user
      end

      context 'with valid params' do
        it 'redirects to the newly updated todo list' do
          put :update, id: @todo_list, todo_list: { name: 'New Name' }
          @todo_list.reload

          expect(@todo_list.name).to eq 'New Name'
          expect(response).to redirect_to @todo_list
          expect(flash[:notice]).to match(/^Todo List successfully updated./)
        end
      end

      context 'with invalid params' do
        it 'renders the form with errors' do
          put :update, id: @todo_list, todo_list: { name: '' }
          @todo_list.reload

          expect(@todo_list.name).not_to eq ''
          expect(response).to render_template :edit
          expect(flash[:error]).to match(/^Validation errors./)
        end
      end
    end

    context 'when another user is logged in' do
      before do
        @owner = create(:user)
        @todo_list = @owner.todo_lists.create(attributes_for(:todo_list))
        @user = create(:user)
        sign_in @user
      end

      context 'with valid params' do
        it 'redirects to the root page with an error' do
          put :update, id: @todo_list, todo_list: { name: 'New Name' }
          @todo_list.reload

          expect(@todo_list.name).not_to eq 'New Name'
          expect(response).to redirect_to root_path
          expect(flash[:alert]).to match(/^You are not the owner of that list or the list does not exist./)
        end
      end

      context 'when the list does not exist' do
        it 'redirects to the root page with an error' do
          put :update, id: (@todo_list.id + 1), todo_list: { name: 'New Name' }
          @todo_list.reload

          expect(@todo_list.name).not_to eq 'New Name'
          expect(response).to redirect_to root_path
          expect(flash[:alert]).to match(/^You are not the owner of that list or the list does not exist./)
        end
      end
    end

    context 'when nobody is logged in' do
      before do
        @owner = create(:user)
        @todo_list = @owner.todo_lists.create(attributes_for(:todo_list))
      end

      context 'with valid params' do
        it 'redirects to the login page with an error' do
          put :update, id: @todo_list, todo_list: { name: 'New Name' }
          @todo_list.reload

          expect(@todo_list.name).not_to eq 'New Name'
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to match(/^You need to sign in or sign up./)
        end
      end
    end
  end

  describe 'GET #show' do
    context 'when the owner is logged in' do
      before do
        @user = create(:user)
        @todo_list = @user.todo_lists.create(attributes_for(:todo_list))
        sign_in @user
      end

      it 'assigns the list and an array of its items' do
        get :show, id: @todo_list

        expect(assigns(:todo_list)).to eq @todo_list
        expect(assigns(:todo_items)).to eq @todo_list.todo_items
      end
    end

    context 'when another user is logged in' do
      before do
        @owner = create(:user)
        @todo_list = @owner.todo_lists.create(attributes_for(:todo_list))
        @user = create(:user)
        sign_in @user
      end

      it 'redirects to the root page with an error' do
        get :show, id: @todo_list

        expect(assigns(:todo_list)).to be_nil
        expect(response).to redirect_to root_path
        expect(flash[:alert]).to match(/^You are not the owner of that list or the list does not exist./)
      end
    end

    context 'when nobody is logged in' do
      before do
        @owner = create(:user)
        @todo_list = @owner.todo_lists.create(attributes_for(:todo_list))
      end

      it 'redirects to the login page with an error' do
        get :show, id: @todo_list

        expect(assigns(:todo_list)).to be_nil
        expect(response).to redirect_to new_user_session_path
        expect(flash[:alert]).to match(/^You need to sign in or sign up./)
      end
    end
  end

  describe 'GET #index' do
    before do
      @user = create(:user)
      3.times { @user.todo_lists.create(attributes_for(:todo_list)) }
    end
    context 'when a user is logged in' do
      it "retrieves all of the user's todo lists" do
        sign_in @user
        get :index

        expect(response).to render_template :index
        expect(assigns(:todo_lists).length).to be(3)
        expect(assigns(:todo_lists)).to eq(@user.todo_lists)
      end

      it "retrieves only that user's todo lists" do
        @other_user = create(:user)
        3.times { @other_user.todo_lists.create(attributes_for(:todo_list)) }

        sign_in @user
        get :index

        expect(response).to render_template :index
        expect(assigns(:todo_lists).length).to be(3)
        expect(assigns(:todo_lists)).to eq(@user.todo_lists)
      end
    end

    context 'when nobody is logged in' do
      it 'redirects to the login page with an error' do
        get :index

        expect(assigns(:todo_lists)).to be_nil
        expect(response).to redirect_to new_user_session_path
        expect(flash[:alert]).to match(/^You need to sign in or sign up./)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when the owner is logged in' do
      before do
        @user = create(:user)
        @todo_list = @user.todo_lists.create(attributes_for(:todo_list))
        sign_in @user
      end

      it 'destroys the todo list' do
        expect do
          delete :destroy, id: @todo_list
        end.to change(TodoList, :count).by(-1)
      end

      it 'redirects to the index' do
        delete :destroy, id: @todo_list

        expect(response).to redirect_to :todo_lists
      end
    end

    context 'when another user is logged in' do
      before do
        @owner = create(:user)
        @todo_list = @owner.todo_lists.create(attributes_for(:todo_list))
        @user = create(:user)
        sign_in @user
      end

      it 'does not destroy the todo list' do
        expect do
          delete :destroy, id: @todo_list
        end.not_to change(TodoList, :count)
      end

      it 'redirects to the root page with an error' do
        delete :destroy, id: @todo_list

        expect(response).to redirect_to root_path
        expect(flash[:alert]).to match(/^You are not the owner of that list or the list does not exist./)
      end
    end

    context 'when nobody is logged in' do
      before do
        @owner = create(:user)
        @todo_list = @owner.todo_lists.create(attributes_for(:todo_list))
      end

      it 'does not destroy the todo list' do
        expect do
          delete :destroy, id: @todo_list
        end.not_to change(TodoList, :count)
      end

      it 'redirects to the login page with an error' do
        delete :destroy, id: @todo_list

        expect(response).to redirect_to new_user_session_path
        expect(flash[:alert]).to match(/^You need to sign in or sign up./)
      end
    end
  end
end
