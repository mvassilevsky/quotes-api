require 'spec_helper'

describe "libraries" do

  subject { page }

  describe "index page" do
    it "creates a library" do
        user = User.create(email: "test@test.com", password: "password")
        library = user.libraries.create(name: "test",
                                        description: "testtest",
                                        access_level: :hidden)
        sign_in_capybara(user)
        visit libraries_path
        should have_css("td", text: "testtest")
    end

    it "can't edit a library while not logged in, redirects instead" do
      user = User.create(email: "test@test.com", password: "password")
      library = user.libraries.create(name: "test",
                                      description: "testtest",
                                      access_level: :shown)
      visit libraries_path
      click_link "Edit"
      expect(current_path).to eq(user_session_path)
    end

    it "can't destroy a library while not logged in, redirects instead" do
      user = User.create(email: "test@test.com", password: "password")
      library = user.libraries.create(name: "test",
                                      description: "testtest",
                                      access_level: :shown)
      visit libraries_path
      click_link "Destroy"
      expect(current_path).to eq(user_session_path)
    end
  end

end
