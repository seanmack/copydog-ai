require "rails_helper"

RSpec.describe Sanitizers::Utilities::InnerHtmlExtractor do
  describe "#extract_inner_html" do
    it "returns the inner HTML of the body element" do
      html_content = <<-HTML
        <html>
          <head>
            <title>Test Title</title>
            <style>body { font-family: Arial; }</style>
            <script>alert('Hello, World!');</script>
          </head>
          <body>
            <h1>Main Title</h1>
            <p>Some content here.</p>
          </body>
        </html>
      HTML

      expected_inner_html = <<-HTML
        <h1>Main Title</h1>
        <p>Some content here.</p>
      HTML

      extractor = described_class.new(html_content: html_content, element: "body")
      result = extractor.extract_inner_html

      expect(result.squish).to eq(expected_inner_html.squish)
    end

    it "returns nil if the specified element is not found" do
      html_content = "<html><body><h1>Main Title</h1></body></html>"

      extractor = described_class.new(html_content: html_content, element: "head")
      result = extractor.extract_inner_html

      expect(result).to be_nil
    end
  end
end
