# Crawls a web page and processes the HTML content via the OpenAI API
#
# The job completes the following tasks:
# 1. Fetches the HTML response from the given URL
# 2. Attaches it to the crawl request
# 3. Analyzes the HTML content and updates the crawl request with the analysis results
# 4. Sends the HTML content to the SendContentForAnalysis service, i.e. to the OpenAI API
# 5. Creates or updates a web page draft with the content from the OpenAI API

class CrawlWebPageJob < ApplicationJob
  queue_as :default

  def perform(crawl_request_id, crawler = Crawlers::SimpleCrawler.new)
    crawl_request = CrawlRequest.find(crawl_request_id)
    result = crawler.fetch(crawl_request.url)

    if result[:success]
      handle_success(crawl_request, result)
    else
      handle_failure(crawl_request, result)
    end
  end

  private

  def handle_success(crawl_request, result)
    html_response = encode_html_response(result:)
    attach_html_response(crawl_request:, html_response:)
    analyze_html_content(crawl_request:, html_response:)
    create_web_page_draft(crawl_request:, html_response:)
  end

  def encode_html_response(result:)
    result[:body].force_encoding("UTF-8")
  end

  def attach_html_response(crawl_request:, html_response:)
    crawl_request.html_response.attach(
      io: StringIO.new(html_response),
      filename: "crawl_response_#{crawl_request.id}.html",
      content_type: "text/html"
    )
  end

  def analyze_html_content(crawl_request:, html_response:)
    page_analysis = PageAnalysis::Parser.new(content: html_response)

    crawl_request.update!(
      status: "completed",
      failure_message: nil,
      title: page_analysis.title,
      meta_description: page_analysis.meta_description
    )
  end

  def create_web_page_draft(crawl_request:, html_response:)
    body = SendContentForAnalysis.new(html: html_response).call
    title = crawl_request.title || "Web Page for #{crawl_request.url}"
    web_page_draft = WebPageDraft.find_or_initialize_by(crawl_request:)
    web_page_draft.update!(title:, body:)
  end

  def handle_failure(crawl_request, result)
    crawl_request.update(status: "failed", failure_message: result[:error])
  end
end
