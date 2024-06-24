module OpenAiService
  class Client
    def initialize
      @client = OpenAI::Client.new
    end

    def send_request(prompt:, content:)
      response = @client.chat(
        parameters: {
          model: "gpt-3.5-turbo",
          messages: [
            { role: "system", content: prompt },
            { role: "user", content: content }
          ]
        }
      )
      response.dig("choices", 0, "message", "content")
    end
  end
end
