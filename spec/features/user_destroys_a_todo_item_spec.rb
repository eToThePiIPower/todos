feature 'User destroys a todo item' do
  before do
    @user = create(:user)
    @todo_list = @user.todo_lists.create(attributes_for(:todo_list))
    @todo_item = @todo_list.todo_items.create(attributes_for(:todo_item))
    login_as(@user, scope: :user)
  end
  after do
    Warden.test_reset!
  end

  scenario 'they see the list on the page' do
    visit todo_list_path @todo_list

    within("//li[@id='#{@todo_item.id}']") do
      click_on 'Delete this item'
    end

    expect(page).to have_content 'Item successfully deleted'
  end
end
