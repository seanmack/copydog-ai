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
    crawl_request.html_response.purge if crawl_request.html_response.attached?

    crawl_request.html_response.attach(
      io: StringIO.new(result[:body]),
      filename: "crawl_response_#{crawl_request.id}.html",
      content_type: "text/html"
    )

    crawl_request.update(status: "completed", failure_message: nil)
  end

  def handle_failure(crawl_request, result)
    crawl_request.update(status: "failed", failure_message: result[:error])
  end
end
