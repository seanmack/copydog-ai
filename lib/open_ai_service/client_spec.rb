require "rails_helper"

RSpec.describe OpenAiService::Client do
  describe "#send_request" do
    it "sends a request to the OpenAI API with the correct parameters and returns the response content" do
      prompt = "Test prompt"
      content = "Test content"

      response_body = {
        "choices" => [
          {
            "message" => {
              "content" => "Test response"
            }
          }
        ]
      }

      client = OpenAiService::Client.new
      allow(client).to receive(:initialize).and_return(OpenAI::Client.new)
      allow_any_instance_of(OpenAI::Client).to receive(:chat).and_return(response_body)

      result = client.send_request(prompt:, content:)

      expect(result).to eq("Test response")
    end
  end
end
