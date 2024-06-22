require "rails_helper"

RSpec.describe Sanitizers::Utilities::Beautifier do
  describe "#sanitize" do
    it "beautifies the HTML content" do
      html_content = "<html><head><title>Test Title</title>   </head><body><h1>Main Title</h1><p>Some content here.</p></body></html>"
      beautified_content = HtmlBeautifier.beautify(html_content)

      beautifier = described_class.new(html_content:)
      result = beautifier.beautify

      expect(result).to eq(beautified_content)
    end
  end
end
