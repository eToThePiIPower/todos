require 'support/share_db_connection'

feature 'User adds a todo item', js: true do
  before do
    @user = create(:user)
    @todo_list = @user.todo_lists.create(attributes_for(:todo_list))
    login_as(@user, scope: :user)
  end
  after do
    Warden.test_reset!
  end

  scenario 'they see a page with exisiting items' do
    create(:todo_item, todo_list: @todo_list,
                       created_at: 1.day.ago, completed_at: 1.hour.ago)
    visit todo_list_path @todo_list

    expect(page).to have_xpath("//div[@aria-valuenow='100']")

    fill_in 'New Item', with: 'My Newest Task'
    click_button 'Add Item'

    expect(find('#alerts')).to have_content('Item added successfully')
    expect(page).to have_xpath("//div[@aria-valuenow='50']")
    expect(first('.todo-list-item')).to have_content 'My Newest Task'
    expect(first('.todo-list-item')).to have_content('Created less than a minute ago')
  end
end
