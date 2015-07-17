require "spec_helper"

describe Quote do

  describe "validations" do
    it "is valid with text, author, and category" do
      quote = Quote.new(text: "text", author: "author", category: "category")
      expect(quote).to be_valid
    end

    it "is invalid without text, author, and category" do
      quote = Quote.new(text: "", author: "", category: "")
      expect(quote).to be_invalid
    end
  end

  describe "full quote" do
    it "generates the full quote with text and author" do
      quote = Quote.new(text: "text", author: "author")
      expect(quote.full_quote).to eq("text -- author")
    end
  end

  describe "set char length" do
    it "sets a char length based on the full quote length" do
      quote = Quote.create(text: "text", author: "author")
      expect(quote.char_length).to eq(14)
    end
  end

end
