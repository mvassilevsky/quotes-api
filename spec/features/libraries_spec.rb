require 'spec_helper'

describe "libraries" do

  subject { page }

  describe "index page" do
    it "displays an existing private library when logged in as its owner" do
      user = User.create(email: "test@test.com", password: "password")
      library = user.libraries.create(name: "test",
                                      description: "testtest",
                                      access_level: :hidden)
      sign_in_capybara(user)
      visit libraries_path
      should have_css("td", text: "testtest")
    end

    it "does not display an existing private library when not logged in" do
      user = User.create(email: "test@test.com", password: "password")
      library = user.libraries.create(name: "test",
                                      description: "testtest",
                                      access_level: :hidden)
      visit libraries_path
      should have_no_css("td", text: "testtest")
    end

    it "displays an existing public library when logged in" do
      user = User.create(email: "test@test.com", password: "password")
      library = user.libraries.create(name: "test",
                                      description: "testtest",
                                      access_level: :shown)
      sign_in_capybara(user)
      visit libraries_path
      should have_css("td", text: "testtest")
    end

    it "displays an existing public library when not logged in" do
      user = User.create(email: "test@test.com", password: "password")
      library = user.libraries.create(name: "test",
                                      description: "testtest",
                                      access_level: :shown)
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

  describe "new page" do
    it "navigates to new library page and creates a new library" do
      user = User.create(email: "test@test.com", password: "password")
      sign_in_capybara(user)
      visit libraries_path
      click_link "New Library"
      fill_in "Name", with: "Test Library"
      fill_in "Description", with: "test description"
      click_button "Create Library"
      expect(Library.last.name).to eq("Test Library")
    end

    it "creates a new private library" do
      user = User.create(email: "test@test.com", password: "password")
      sign_in_capybara(user)
      visit new_library_path
      fill_in "Name", with: "Test Library"
      fill_in "Description", with: "test description"
      choose "private"
      click_button "Create Library"
      expect(Library.last.access_level).to eq("hidden")
    end

    it "creates a new public library" do
      user = User.create(email: "test@test.com", password: "password")
      sign_in_capybara(user)
      visit new_library_path
      fill_in "Name", with: "Test Library"
      fill_in "Description", with: "test description"
      choose "public"
      click_button "Create Library"
      expect(Library.last.access_level).to eq("shown")
    end
  end

  describe "show page" do
    it "displays the library title, description, and access level" do
      user = User.create(email: "test@test.com", password: "password")
      library = user.libraries.create(name: "test",
                                      description: "testtest",
                                      access_level: :hidden)
      sign_in_capybara(user)
      visit library_path(library.id)
      should have_css("strong", text: "test")
      should have_content("testtest")
      should have_content("Access level: private")
    end

    it "creates and displays a new quote" do
      user = User.create(email: "test@test.com", password: "password")
      library = user.libraries.create(name: "test",
                                      description: "testtest",
                                      access_level: :hidden)
      sign_in_capybara(user)
      visit library_path(library.id)
      fill_in "Text", with: "Test quote"
      fill_in "Author", with: "Test Author"
      fill_in "Source", with: "Test"
      fill_in "Category", with: "Test quotes"
      click_button "Create Quote"
      should have_css("a", "Test quote -- Test Author")
    end
  end

end
