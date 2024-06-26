require "rails_helper"

RSpec.describe OpenAiService::Strategies::ExtractMainContentStrategy do
  describe "#content" do
    it "sanitizes the HTML content using the provided sanitizer" do
      html_content = "<html><body><h1>Main Content</h1><p>This is a paragraph.</p></body></html>"
      sanitized_content = "<h1>Main Content</h1><p>This is a paragraph.</p>"
      sanitizer_instance = instance_double("Sanitizers::SimpleSanitizer")

      allow(Sanitizers::SimpleSanitizer).to receive(:new).with(html_content:).and_return(sanitizer_instance)
      allow(sanitizer_instance).to receive(:sanitize).and_return(sanitized_content)

      strategy = described_class.new
      result = strategy.content(html_content:, sanitizer: Sanitizers::SimpleSanitizer)

      expect(sanitizer_instance).to have_received(:sanitize)
      expect(result).to eq(sanitized_content)
    end
  end
end
