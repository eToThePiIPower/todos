feature 'User can log in successfully' do
  before do
    @user = create(:user)
  end

  scenario 'they enter the password correctly' do
    visit new_user_session_path

    within("//form[@id='page-login-form']") do
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log In'
    end

    expect(page).to have_content @user.email
    expect(page).to have_content 'Signed in successfully'
  end

  scenario 'they enter the password incorrectly' do
    visit new_user_session_path

    within("//form[@id='page-login-form']") do
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: 'invalid'
      click_button 'Log In'
    end

    expect(page).not_to have_content @user.email
    expect(page).to have_content 'Invalid Email or password'
  end

  scenario 'they use the modal login' do
    visit root_path

    within("//form[@id='modal-login-form']") do
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log In'
    end

    expect(page).to have_content @user.email
    expect(page).to have_content 'Signed in successfully'
  end
end
