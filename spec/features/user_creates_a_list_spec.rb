feature 'User creates a list' do
  before do
    @user = create(:user)
    login_as(@user, scope: :user)
  end
  after do
    Warden.test_reset!
  end

  scenario 'they see the list form on the page' do
    visit new_todo_list_path

    fill_in 'Name', with: 'My List'
    fill_in 'Description', with: 'My Description'
    click_button 'Create Todo List'

    expect(page).to have_content 'successfully created'
    expect(TodoList.last).to have_attributes(name: 'My List')
  end
end
