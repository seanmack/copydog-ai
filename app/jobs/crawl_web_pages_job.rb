class CrawlWebPagesJob < ApplicationJob
  queue_as :default

  def perform(bulk_crawl_request_id)
    bulk_crawl_request = BulkCrawlRequest.find(bulk_crawl_request_id)
    urls = extract_urls(bulk_crawl_request:)
    create_crawl_requests(urls:, bulk_crawl_request:)
    trigger_crawl_jobs(bulk_crawl_request:)
  end

  private

  def extract_urls(bulk_crawl_request:)
    TextListParser.new(text_list: bulk_crawl_request.urls).items
  end

  def create_crawl_requests(urls:, bulk_crawl_request:)
    urls.each do |url|
      crawl_request = CrawlRequest.create(url:, bulk_crawl_request:)

      if !crawl_request.valid?
        Rails.logger.error("Failed to create CrawlRequest for URL: #{url}")
        next
      end
    end
  end

  def trigger_crawl_jobs(bulk_crawl_request:)
    bulk_crawl_request.crawl_requests.each do |crawl_request|
      CrawlWebPageJob.perform_later(crawl_request.id)
    end
  end
end
