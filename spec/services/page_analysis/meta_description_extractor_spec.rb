require "rails_helper"

RSpec.describe PageAnalysis::MetaDescriptionExtractor do
  describe ".extract" do
    it "extracts the meta description from the HTML content" do
      html = "<html><head><meta name='description' content='Test Description'></head><body></body></html>"
      doc = Nokogiri::HTML(html)
      description = described_class.extract(doc)
      expect(description).to eq("Test Description")
    end

    it "returns nil if the meta description tag is not present" do
      html = "<html><head></head><body></body></html>"
      doc = Nokogiri::HTML(html)
      description = described_class.extract(doc)
      expect(description).to be_nil
    end

    it "returns nil if the meta description tag is empty" do
      html = "<html><head><meta name='description' content=''></head><body></body></html>"
      doc = Nokogiri::HTML(html)
      description = described_class.extract(doc)
      expect(description).to be_nil
    end
  end
end
