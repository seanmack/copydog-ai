# spec/text_list_parser_spec.rb
require "rails_helper"

RSpec.describe TextListParser, type: :model do
  describe "#items" do
    it "returns an empty array if the input is nil" do
      parser = TextListParser.new(text_list: nil)
      expect(parser.items).to eq([])
    end

    it "returns an empty array if the input is an empty string" do
      parser = TextListParser.new(text_list: "")
      expect(parser.items).to eq([])
    end

    it "returns an array of items when input contains items separated by newlines" do
      input = "item1\nitem2"
      parser = TextListParser.new(text_list: input)
      expect(parser.items).to eq(["item1", "item2"])
    end

    it "handles leading and trailing whitespace in items" do
      input = "  item1  \n  item2  "
      parser = TextListParser.new(text_list: input)
      expect(parser.items).to eq(["item1", "item2"])
    end

    it "ignores empty lines" do
      input = "item1\n\nitem2"
      parser = TextListParser.new(text_list: input)
      expect(parser.items).to eq(["item1", "item2"])
    end

    it "handles carriage return characters" do
      input = "item1\r\nitem2"
      parser = TextListParser.new(text_list: input)
      expect(parser.items).to eq(["item1", "item2"])
    end

    it "handles a mixture of all scenarios" do
      input = "\r\n  item1  \r\n\n  item2  \n\n"
      parser = TextListParser.new(text_list: input)
      expect(parser.items).to eq(["item1", "item2"])
    end
  end
end
