require "rails_helper"

RSpec.describe Sanitizers::Utilities::ElementRemover do
  describe "#remove_elements" do
    it "calls Sanitize.fragment with the correct arguments" do
      html_content = "<div></div>"
      config = { elements: %w[div span], attributes: { "a" => %w[href] } }
      sanitizer = described_class.new(html_content:, config:)

      allow(Sanitize).to receive(:fragment).and_return("")

      sanitizer.remove_elements

      expect(Sanitize).to have_received(:fragment).with(html_content, config)
    end

    it "uses the default config when no config is provided" do
      html_content = "<div></div>"
      default_config = Sanitizers::DEFAULT_SANITIZER_CONFIG
      sanitizer = described_class.new(html_content:)

      allow(Sanitize).to receive(:fragment).and_return("")

      sanitizer.remove_elements

      expect(Sanitize).to have_received(:fragment).with(html_content, default_config)
    end
  end
end
