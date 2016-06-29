module LoginHelpers
  def login_as(user)
    visit new_user_session_path
    within("//form[@id='modal-login-form']") do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log In'
    end
  end

  def create_and_login_as_user
    user = FactoryGirl.create(:user)
    login_as(user)
    user
  end
end
