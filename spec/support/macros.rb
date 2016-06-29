module Macros
  def expect_it_to_require_the_user_be_signed_in
    expect(response).to redirect_to new_user_session_path
    expect(flash[:alert]).to match(/^You need to sign in or sign up before continuing./)
  end

  def expect_it_to_return_an_authorization_error
    expect(response).to redirect_to root_path
    expect(flash[:alert]).to match(/^You are not the owner of that list or the list does not exist./)
  end
end
