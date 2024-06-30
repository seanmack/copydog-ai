# Sends HTML content for analysis using a specified strategy.
#
# @param html [String] The HTML content to be analyzed.
# @param client [Class] The client class to use for sending the request. Defaults to OpenAiService::Client.
# @param strategy [Class] The strategy class to use for extracting main content. Defaults to OpenAiService::Strategies::ExtractMainContentStrategy.
#
# @example
#   analysis = SendContentForAnalysis.new(html: "<html>...</html>")
#   result = analysis.call
#   # result contains the response from the analysis service.
#
# @return [String/nil] The response from the client request.

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
