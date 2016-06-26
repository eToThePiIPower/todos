feature 'User destroys a todo item' do
  before do
    @todo_list = create(:todo_list)
    @todo_item = @todo_list.todo_items.create(attributes_for(:todo_item))
  end

  scenario 'they see the list on the page' do
    visit todo_list_path @todo_list

    within("//li[@id='#{@todo_item.id}']") do
      click_on 'Delete this item'
    end

    expect(page).to have_content 'Item successfully deleted'
  end
end
