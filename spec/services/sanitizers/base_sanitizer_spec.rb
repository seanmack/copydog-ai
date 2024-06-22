require "rails_helper"

RSpec.describe Sanitizers::BaseSanitizer do
  describe "#sanitize" do
    it "raises a NotImplementedError" do
      sanitizer = described_class.new
      expect { sanitizer.sanitize }.to raise_error(NotImplementedError, "Subclasses must implement the sanitize method")
    end
  end

  describe "#extract_inner_html" do
    it "calls InnerHtmlExtractor with the correct arguments and returns the result" do
      html_content = "<html><head></head><body></body></html>"
      sanitizer = described_class.new
      extractor_double = instance_double(Sanitizers::Utilities::InnerHtmlExtractor)

      allow(Sanitizers::Utilities::InnerHtmlExtractor).to receive(:new).with(html_content: html_content, element: "body").and_return(extractor_double)
      allow(extractor_double).to receive(:extract_inner_html).and_return("<body></body>")

      result = sanitizer.send(:extract_inner_html, html_content: html_content, element: "body")

      expect(result).to eq("<body></body>")
      expect(Sanitizers::Utilities::InnerHtmlExtractor).to have_received(:new).with(html_content: html_content, element: "body")
      expect(extractor_double).to have_received(:extract_inner_html)
    end
  end

  describe "#remove_elements" do
    it "calls ElementRemover with the correct arguments and returns the result" do
      html_content = "<html><head></head><body></body></html>"
      sanitizer = described_class.new
      remover_double = instance_double(Sanitizers::Utilities::ElementRemover)

      allow(Sanitizers::Utilities::ElementRemover).to receive(:new).with(html_content: html_content, elements: %w[head script style]).and_return(remover_double)
      allow(remover_double).to receive(:remove_elements).and_return("<html><body></body></html>")

      result = sanitizer.send(:remove_elements, html_content: html_content)

      expect(result).to eq("<html><body></body></html>")
      expect(Sanitizers::Utilities::ElementRemover).to have_received(:new).with(html_content: html_content, elements: %w[head script style])
      expect(remover_double).to have_received(:remove_elements)
    end
  end

  describe "#beautify" do
    it "calls Beautifier with the correct arguments and returns the result" do
      html_content = "<html><head></head><body></body></html>"
      sanitizer = described_class.new
      beautifier_double = instance_double(Sanitizers::Utilities::Beautifier)

      allow(Sanitizers::Utilities::Beautifier).to receive(:new).with(html_content: html_content).and_return(beautifier_double)
      allow(beautifier_double).to receive(:beautify).and_return("<html>\n  <head>\n  </head>\n  <body>\n  </body>\n</html>")

      result = sanitizer.send(:beautify, html_content: html_content)

      expect(result).to eq("<html>\n  <head>\n  </head>\n  <body>\n  </body>\n</html>")
      expect(Sanitizers::Utilities::Beautifier).to have_received(:new).with(html_content: html_content)
      expect(beautifier_double).to have_received(:beautify)
    end
  end
end
