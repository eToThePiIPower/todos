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
    create(:todo_item, todo_list: @todo_list, name: 'Item 1',
                       created_at: 2.days.ago, completed_at: 1.day.ago)
    visit todo_list_path @todo_list

    expect(page).to have_xpath("//div[@aria-valuenow='100']")

    click_link 'Uncomplete this item'

    expect(find('#alerts')).to have_content('Item marked incomplete')
    expect(page).to have_xpath("//div[@aria-valuenow='0']")
    expect(find('.todo-list-item.todo-list-item-incomplete')).to have_content('Item 1')
  end
end
