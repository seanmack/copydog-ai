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

  # TODO: This needs a refactor. But while we're still
  # developing the feature, it's easiest to see everything in one place.
  def handle_success(crawl_request, result)
    html_response = result[:body].force_encoding("UTF-8")

    # Purge the existing attachment if it exists
    crawl_request.html_response.purge if crawl_request.html_response.attached?

    # Attach the new HTML response
    crawl_request.html_response.attach(
      io: StringIO.new(html_response),
      filename: "crawl_response_#{crawl_request.id}.html",
      content_type: "text/html"
    )

    # Parse the page and send the HTML for analysis (this will need error handling)
    page_analysis = PageAnalysis::Parser.new(content: html_response)

    # Update the crawl request with the analysis results
    crawl_request.update!(
      status: "completed",
      failure_message: nil,
      title: page_analysis.title,
      meta_description: page_analysis.meta_description
    )

    # Ask OpenAI to analyze the content of the page
    body = SendContentForAnalysis.new(html: html_response).call

    # Create a web page draft with the analysis results
    web_page_draft = WebPageDraft.find_or_initialize_by(crawl_request:)

    web_page_draft.update!(
      title: page_analysis.title || "Web Page Title",
      body:
    )
  end

  def handle_failure(crawl_request, result)
    crawl_request.update(status: "failed", failure_message: result[:error])
  end
end
