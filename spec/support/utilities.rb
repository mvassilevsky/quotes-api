include ApplicationHelper

def sign_in_capybara(user)
  visit user_session_path
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

def sign_out_capybara
  click_link "Sign out"
end

def test_user
  User.create(email: "test@test.com", password: "password")
end

def test_library(user, visibility)
  user.libraries.create(name: "test",
                        description: "testtest",
                        access_level: visibility)
end
