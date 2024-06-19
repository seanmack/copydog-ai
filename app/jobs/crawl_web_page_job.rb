class CrawlWebPageJob < ApplicationJob
  queue_as :default

  def perform(crawl_request_id, crawler = Crawlers::SimpleCrawler.new)
    crawl_request = CrawlRequest.find(crawl_request_id)
    result = crawler.fetch(crawl_request.url)

    if result[:success]
      # TODO: Save the response and details
      crawl_request.update(status: "completed", failure_message: nil)
    else
      crawl_request.update(status: "failed", failure_message: result[:error])
    end
  end
end
