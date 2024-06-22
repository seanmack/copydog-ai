require "rails_helper"

RSpec.describe Sanitizers::Utilities::ElementRemover do
  describe "#remove_elements" do
    it "removes elements from the HTML" do
      elements = %w[head script style]

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

      result = described_class.new(html_content:, elements:).remove_elements

      elements.each do |element|
        expect(Nokogiri::HTML(result).at(element)).to be_nil
      end

      expect(result.strip).to include("<html>")
      expect(result.strip).to include("<body>")
      expect(result.strip).to include("<h1>Main Title</h1>")
      expect(result.strip).to include("<p>Some content here.</p>")
    end
  end
end
