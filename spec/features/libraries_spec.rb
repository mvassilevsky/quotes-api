require 'spec_helper'

describe "libraries" do

  subject { page }

  describe "index page" do
    it {
        user = User.create(email: "test@test.com", password: "password")
        library = user.libraries.create(name: "test",
                                        description: "testtest",
                                        access_level: :hidden)
        sign_in_capybara(user)
        visit libraries_path
        should have_css("td", text: "testtest")
       }
  end

end
