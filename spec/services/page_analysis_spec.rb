require "rails_helper"

RSpec.describe PageAnalysis do
  describe "#initialize" do
    it "extracts the title from the HTML content" do
      content = "<html><head><title>Test Page</title></head><body></body></html>"
      analysis = PageAnalysis.new(content: content)
      expect(analysis.title).to eq("Test Page")
    end

    it "returns nil if the title tag is not present" do
      content = "<html><head></head><body></body></html>"
      analysis = PageAnalysis.new(content: content)
      expect(analysis.title).to be_nil
    end

    it "returns nil if the title tag is empty" do
      content = "<html><head><title></title></head><body></body></html>"
      analysis = PageAnalysis.new(content: content)
      expect(analysis.title).to be_nil
    end
  end
end
