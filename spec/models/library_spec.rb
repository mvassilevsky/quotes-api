require "spec_helper"

describe Library do

  describe "validations" do
    it "is valid with a name" do
      library = Library.new(name: "name")
      expect(library).to be_valid
    end

    it "is invalid without a name" do
      library = Library.new(name: "")
      expect(library).to be_invalid
    end
  end

  describe "access level" do
    it "is hidden when created as hidden" do
      library = Library.new(name: "name")
      library.access_level = :hidden
      expect(library.hidden?).to be(true)
    end

    it "is shown when created as shown" do
      library = Library.new(name: "name")
      library.access_level = :shown
      expect(library.shown?).to be(true)
    end
  end

end
