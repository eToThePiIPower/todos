feature 'User adds a todo item' do
  before do
    @user = create(:user)
    @todo_list = @user.todo_lists.create(attributes_for(:todo_list))
    login_as @user
  end

  scenario 'they see the list on the page' do
    visit todo_list_path @todo_list

    fill_in 'New Item', with: 'My Newest Task'
    click_button 'Add Item'

    expect(page).to have_content 'Item successfully added'
    expect(@todo_list.todo_items.last).to have_attributes(name: 'My Newest Task')
  end
end
