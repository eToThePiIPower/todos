feature 'User can recover their password' do
  before do
    @user = create(:user)
  end

  scenario 'they request a password change' do
    visit new_user_password_path

    within("//form[@id='page-new-password-form']") do
      fill_in 'Email', with: @user.email
      click_button 'Send me reset password instructions'
    end

    mail = ActionMailer::Base.deliveries.last
    expect(mail.to).to include @user.email
    expect(mail.body).to have_content 'Someone has requested a link to change your password'
    expect(page).to have_content 'You will receive an email with instructions'
  end
end
