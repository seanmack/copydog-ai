module OpenAiService
  # A client for interacting with the OpenAI service.
  #
  # @example
  #   client = OpenAiService::Client.new
  #   response = client.send_request(prompt: "Analyze this text", content: "Sample content")
  #   # response contains the content of the AI's reply.
  #
  # @param prompt [String] The system prompt to send to the AI.
  # @param content [String] The user content to analyze.
  #
  # @return [String, nil] The content of the AI's response, or nil if not found.

  class Client
    def initialize
      @client = OpenAI::Client.new
    end

    def send_request(prompt:, content:)
      parameters = build_parameters(prompt:, content:)
      response = @client.chat(parameters:)
      response.dig("choices", 0, "message", "content")
    end

    private

    def build_parameters(prompt:, content:)
      {
        model: "gpt-3.5-turbo",
        messages: [
          { role: "system", content: prompt },
          { role: "user", content: content }
        ]
      }
    end
  end
end
