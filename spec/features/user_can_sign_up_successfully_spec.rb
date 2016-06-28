feature 'User can sign up successfully' do
  scenario 'they enter the information correctly' do
    visit new_user_registration_path

    within("//form[@id='page-signup-form']") do
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_button 'Sign Up'
    end

    expect(page).to have_content 'user@example.com'
    expect(page).to have_content 'You have signed up successfully'
  end

  scenario 'they enter the information incorrectly' do
    visit new_user_registration_path

    within("//form[@id='page-signup-form']") do
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'missing'
      fill_in 'Password confirmation', with: ''
      click_button 'Sign Up'
    end

    expect(page).not_to have_content 'user@example.com'
    expect(page).to have_content(/errors? prohibited this user from being saved/)
    expect(page).to have_content(/Password confirmation doesn't match Password/)
  end

  scenario 'use the modal signup' do
    visit root_path

    within("//form[@id='modal-signup-form']") do
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_button 'Sign Up'
    end

    expect(page).to have_content 'user@example.com'
    expect(page).to have_content 'You have signed up successfully'
  end
end
