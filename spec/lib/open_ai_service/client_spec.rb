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

      allow_any_instance_of(OpenAI::Client).to receive(:chat).and_return(response_body)

      client = OpenAiService::Client.new
      result = client.send_request(prompt:, content:)

      expect(result).to eq("Test response")
    end
  end

  describe "#build_parameters" do
    it "builds the correct parameters for the OpenAI API request" do
      prompt = "Test prompt"
      content = "Test content"

      client = OpenAiService::Client.new
      parameters = client.send(:build_parameters, prompt:, content:)

      expected_parameters = {
        model: "gpt-3.5-turbo",
        messages: [
          { role: "system", content: prompt },
          { role: "user", content: content }
        ]
      }

      expect(parameters).to eq(expected_parameters)
    end
  end
end
