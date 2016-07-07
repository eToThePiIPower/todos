feature 'User adds a todo item' do
  before do
    @user = create(:user)
    @todo_list = @user.todo_lists.create(attributes_for(:todo_list))
    login_as(@user, scope: :user)
  end
  after do
    Warden.test_reset!
  end

  scenario 'they see the list on the page' do
    visit todo_list_path @todo_list

    fill_in 'New Item', with: 'My Newest Task'
    fill_in 'Due At', with: 1.day.from_now.in_time_zone('America/New_York').strftime('%Y-%m-%dT%T')
    click_button 'Add Item'

    expect(page).to have_content 'Item successfully added'
    expect(@todo_list.todo_items.last).to have_attributes(name: 'My Newest Task')
    expect(@todo_list.todo_items.last.due_at).to be_within(5.seconds).of(1.day.from_now)
  end
end
