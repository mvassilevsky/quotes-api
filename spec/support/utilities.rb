include ApplicationHelper

def sign_in_capybara(user)
  visit user_session_path
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Log in"
end

def sign_out_capybara
  click_link "Sign out"
end
