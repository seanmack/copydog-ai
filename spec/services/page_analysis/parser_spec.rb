require "rails_helper"

module PageAnalysis
  RSpec.describe Parser do
    describe "#initialize" do
      it "extracts the title using TitleExtractor" do
        content = "<html><head><title>Test Page</title></head><body></body></html>"

        parser = described_class.new(content: content)

        expect(parser.title).to eq("Test Page")
      end

      it "extracts the meta description using MetaDescriptionExtractor" do
        content = "<html><head><meta name='description' content='Test Description'></head><body></body></html>"

        parser = described_class.new(content: content)

        expect(parser.meta_description).to eq("Test Description")
      end
    end
  end
end
