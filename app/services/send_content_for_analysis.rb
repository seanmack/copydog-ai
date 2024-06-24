class SendContentForAnalysis
  attr_reader :html, :client, :strategy

  def initialize(html:, client: OpenAiService::Client, strategy: OpenAiService::Strategies::ExtractMainContentStrategy)
    @html = html
    @client = client.new
    @strategy = strategy.new
  end

  def call
    response = client.send_request(prompt:, content:)
    response
  end

  private

  def content
    strategy.content(html_content: html)
  end

  def prompt
    strategy.prompt
  end
end
