require "rails_helper"

RSpec.describe PageAnalysis::TitleExtractor do
  describe ".extract" do
    it "extracts the title from the HTML content" do
      html = "<html><head><title>Test Page</title></head><body></body></html>"
      doc = Nokogiri::HTML(html)
      title = described_class.extract(doc)
      expect(title).to eq("Test Page")
    end

    it "returns nil if the title tag is not present" do
      html = "<html><head></head><body></body></html>"
      doc = Nokogiri::HTML(html)
      title = described_class.extract(doc)
      expect(title).to be_nil
    end

    it "returns nil if the title tag is empty" do
      html = "<html><head><title></title></head><body></body></html>"
      doc = Nokogiri::HTML(html)
      title = described_class.extract(doc)
      expect(title).to be_nil
    end
  end
end
