require 'spec_helper'

describe "libraries" do

  subject { page }

  describe "index page" do
    it "displays an existing private library when logged in as its owner" do
      user = test_user
      library = test_library(user, :hidden)
      sign_in_capybara(user)
      visit libraries_path
      should have_css("td", text: "testtest")
    end

    it "does not display an existing private library when not logged in" do
      user = test_user
      library = test_library(user, :hidden)
      visit libraries_path
      should have_no_css("td", text: "testtest")
    end

    it "displays an existing public library when logged in" do
      user = test_user
      library = test_library(user, :shown)
      sign_in_capybara(user)
      visit libraries_path
      should have_css("td", text: "testtest")
    end

    it "displays an existing public library when not logged in" do
      user = test_user
      library = test_library(user, :shown)
      visit libraries_path
      should have_css("td", text: "testtest")
    end

    it "can't edit a library while not logged in, redirects instead" do
      user = test_user
      library = test_library(user, :shown)
      visit libraries_path
      click_link "Edit"
      expect(current_path).to eq(user_session_path)
    end

    it "can't destroy a library while not logged in, redirects instead" do
      user = test_user
      library = test_library(user, :shown)
      visit libraries_path
      click_link "Destroy"
      expect(current_path).to eq(user_session_path)
    end
  end

  describe "new page" do
    it "navigates to new library page and creates a new library" do
      user = test_user
      sign_in_capybara(user)
      visit libraries_path
      click_link "New Library"
      fill_in "Name", with: "Test Library"
      fill_in "Description", with: "test description"
      click_button "Create Library"
      expect(Library.last.name).to eq("Test Library")
    end

    it "creates a new private library" do
      user = test_user
      sign_in_capybara(user)
      visit new_library_path
      fill_in "Name", with: "Test Library"
      fill_in "Description", with: "test description"
      choose "private"
      click_button "Create Library"
      expect(Library.last.access_level).to eq("hidden")
    end

    it "creates a new public library" do
      user = test_user
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
    it "redirects when accessing a private library when not logged in" do
      user = test_user
      library = test_library(user, :hidden)
      visit library_path(library.id)
      expect(current_path).to eq(libraries_path)
    end

    it "shows a public library when not logged in" do
      user = test_user
      library = test_library(user, :shown)
      visit library_path(library.id)
      expect(current_path).to eq(library_path(library.id))
    end

    it "displays the library title, description, and access level" do
      user = test_user
      library = test_library(user, :hidden)
      sign_in_capybara(user)
      visit library_path(library.id)
      should have_css("h1", text: "test")
      should have_content("testtest")
      should have_content("Access level: private")
    end

    it "creates and displays a new quote" do
      user = test_user
      library = test_library(user, :hidden)
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

  describe "edit page" do
    it "can change a library's name" do
      user = test_user
      library = test_library(user, :hidden)
      sign_in_capybara(user)
      visit edit_library_path(library.id)
      fill_in "Name", with: "Changed name"
      click_button "Update Library"
      expect(Library.last.name).to eq("Changed name")
    end

    it "can change a library's description" do
      user = test_user
      library = test_library(user, :hidden)
      sign_in_capybara(user)
      visit edit_library_path(library.id)
      fill_in "Description", with: "Changed description"
      click_button "Update Library"
      expect(Library.last.description).to eq("Changed description")
    end

    it "can change a library's access level" do
      user = test_user
      library = test_library(user, :hidden)
      sign_in_capybara(user)
      visit edit_library_path(library.id)
      choose "public"
      click_button "Update Library"
      expect(Library.last.access_level).to eq("shown")
    end
  end

  describe "random" do
    it "gets a random quote" do
      user = test_user
      library = test_library(user, :shown)
      quote = library.quotes.create(text: "test quote",
                                    author: "test author",
                                    category: "test quotes")
      visit random_library_path(library.id)
      should have_content("test quote -- test author")
    end

    it "limits quotes by length of max_chars" do
      user = test_user
      library = test_library(user, :shown)
      quote1 = library.quotes.create(text: "test quote",
                                     author: "test author",
                                     category: "test quotes")
      quote2 = library.quotes.create(text: "long long long long quote",
                                     author: "long long long long author",
                                     category: "long long long long quotes")
      visit random_library_path(library.id, max_chars: 25)
      should have_content("test quote -- test author")
    end

    it "returns an empty string if all quotes are longer than max_chars" do
      user = test_user
      library = test_library(user, :shown)
      quote1 = library.quotes.create(text: "test quote",
                                    author: "test author",
                                    category: "test quotes")
      quote2 = library.quotes.create(text: "long long long long quote",
                                     author: "long long long long author",
                                     category: "long long long long quotes")
      visit random_library_path(library.id, max_chars: 1)
      expect(page.body).to eq("")
    end
  end

  describe "iframe" do
    it "gets a random quote" do
      user = test_user
      library = test_library(user, :shown)
      quote = library.quotes.create(text: "test quote",
                                    author: "test author",
                                    category: "test quotes")
      visit iframe_library_path(library.id)
      should have_content("test quote -- test author")
    end
  end

end

def test_user
  User.create(email: "test@test.com", password: "password")
end

def test_library(user, visibility)
  user.libraries.create(name: "test",
                        description: "testtest",
                        access_level: visibility)
end
