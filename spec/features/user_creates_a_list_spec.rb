feature 'User creates a list' do
  scenario 'they see the list form on the page' do
    @user = create(:user)
    login_as(@user)

    visit new_todo_list_path

    fill_in 'Name', with: 'My List'
    fill_in 'Description', with: 'My Description'
    click_button 'Create Todo List'

    expect(page).to have_content 'successfully created'
    expect(TodoList.last).to have_attributes(name: 'My List')
  end
end
