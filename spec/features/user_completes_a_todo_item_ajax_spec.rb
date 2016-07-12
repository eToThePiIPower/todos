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
    create(:todo_item, todo_list: @todo_list, created_at: 2.days.ago)
    visit todo_list_path @todo_list

    expect(page).to have_xpath("//div[@aria-valuenow='0']")

    click_link 'Complete this item'

    expect(find('#alerts')).to have_content('Item marked complete')
    expect(page).to have_xpath("//div[@aria-valuenow='100']")
    expect(find('.todo-list-item.todo-list-item-complete')).to have_content('Completed less than a minute ago')
  end

  scenario 'it keeps archived items in the archives' do
    create(:todo_item, todo_list: @todo_list, created_at: 2.days.ago)
    create(:todo_item, todo_list: @todo_list, created_at: 9.days.ago, completed_at: 8.days.ago)
    visit todo_list_path @todo_list

    click_link 'Complete this item'

    expect(page).not_to have_css '#todo-items-active li.todo-list-item-archived'
    click_on 'Archives'
    expect(page).to have_css '#todo-items-archived li.todo-list-item-archived'
  end
end
