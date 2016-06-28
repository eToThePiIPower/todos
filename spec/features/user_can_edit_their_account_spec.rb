feature 'User can edit their account' do
  before do
    @user = create(:user)
    visit root_path
    within("//form[@id='modal-login-form']") do
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log In'
    end
  end

  scenario 'they change their email address' do
    visit edit_user_registration_path

    within("//form[@id='page-edit-form']") do
      fill_in 'Email', with: 'some_new_address@domain.com'
      fill_in 'Current password', with: @user.password
      click_button 'Edit User'
    end

    @user.reload
    expect(@user.email).to eq 'some_new_address@domain.com'
    expect(page).to have_content 'Your account has been updated'
  end

  scenario 'they change their password' do
    visit edit_user_registration_path

    within("//form[@id='page-edit-form']") do
      fill_in 'Password', with: 'some new password'
      fill_in 'Password confirmation', with: 'some new password'
      fill_in 'Current password', with: @user.password
      click_button 'Edit User'
    end

    expect(@user.encrypted_password).not_to eq @user.reload.encrypted_password
    expect(page).to have_content 'Your account has been updated'
  end
end
