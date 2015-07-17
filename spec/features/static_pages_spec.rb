require 'spec_helper'

describe "static pages" do

  subject { page }

  describe "about page" do
    it "has the correct header" do
        visit about_path
        should have_css("h1", text: "Quotes API")
    end
  end

end
