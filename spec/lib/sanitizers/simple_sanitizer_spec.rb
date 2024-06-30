require "rails_helper"

RSpec.describe Sanitizers::SimpleSanitizer do
  describe "#sanitize" do
    it "calls extract_inner_html, remove_elements, and beautify in sequence and returns the final result" do
      html_content = "initial content"
      sanitizer = described_class.new(html_content:)

      # Stub the inherited methods
      allow(sanitizer).to receive(:extract_inner_html).with(html_content:).and_return("step 1")
      allow(sanitizer).to receive(:remove_elements).with(html_content: "step 1").and_return("step 2")
      allow(sanitizer).to receive(:beautify).with(html_content: "step 2").and_return("step 3")

      result = sanitizer.sanitize

      expect(sanitizer).to have_received(:extract_inner_html).with(html_content:)
      expect(sanitizer).to have_received(:remove_elements).with(html_content: "step 1")
      expect(sanitizer).to have_received(:beautify).with(html_content: "step 2")
      expect(result).to eq("step 3")
    end
  end
end
