module OpenAiService
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
