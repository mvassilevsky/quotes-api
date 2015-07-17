require 'spec_helper'

describe "static pages" do

  subject { page }

  describe "about page" do
    it {
        visit about_path
        should have_css("h1", text: "Quotes API")
       }
  end

end
