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

  # TODO: This method is long and could use a refactor. But while we're still
  # developing the feature, it's easiest to see everything in one place.
  def handle_success(crawl_request, result)
    crawl_request.html_response.purge if crawl_request.html_response.attached?

    crawl_request.html_response.attach(
      io: StringIO.new(result[:body]),
      filename: "crawl_response_#{crawl_request.id}.html",
      content_type: "text/html"
    )

    page_analysis = PageAnalysis.new(content: result[:body])

    crawl_request.update(
      status: "completed",
      failure_message: nil,
      title: page_analysis.title,
    )
  end

  def handle_failure(crawl_request, result)
    crawl_request.update(status: "failed", failure_message: result[:error])
  end
end
