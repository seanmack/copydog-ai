require "rails_helper"

RSpec.describe SendContentForAnalysis do
  describe "#call" do
    it "sends the content for analysis using the default strategy and client" do
      html_content = "<html><body>Test Content</body></html>"
      service, strategy_instance, client_instance = create_service_instance(OpenAiService::Client, OpenAiService::Strategies::ExtractMainContentStrategy, html_content)

      result = service.call

      expect(result).to eq("Analyzed main content")
      expect(strategy_instance).to have_received(:content).with(html_content: html_content)
      expect(client_instance).to have_received(:send_request).with(prompt: "test prompt", content: "<body>Sanitized content</body>")
    end

    it "sends the content for analysis using the provided strategy and client" do
      custom_client_class = class_double("CustomClientClass").as_stubbed_const
      custom_strategy_class = class_double("CustomStrategyClass").as_stubbed_const
      html_content = "<html><body>Test Content</body></html>"
      service, strategy_instance, client_instance = create_service_instance(custom_client_class, custom_strategy_class, html_content)

      result = service.call

      expect(result).to eq("Analyzed main content")
      expect(strategy_instance).to have_received(:content).with(html_content: html_content)
      expect(client_instance).to have_received(:send_request).with(prompt: "test prompt", content: "<body>Sanitized content</body>")
    end

    def create_service_instance(client_class, strategy_class, html_content)
      client_instance = instance_double(client_class.to_s, send_request: "Analyzed main content")
      strategy_instance = instance_double(strategy_class.to_s, prompt: "test prompt", content: "<body>Sanitized content</body>")

      allow(client_class).to receive(:new).and_return(client_instance)
      allow(strategy_class).to receive(:new).and_return(strategy_instance)

      service = described_class.new(html: html_content, client: client_class, strategy: strategy_class)
      [service, strategy_instance, client_instance]
    end
  end
end
