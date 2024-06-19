require "rails_helper"

RSpec.describe CrawlWebPageJob, type: :job do
  it "updates the status to completed when the crawl is successful" do
    crawl_request = create(:crawl_request)
    crawler = mock_crawler_with(success: true, body: "<html></html>")

    described_class.perform_now(crawl_request.id, crawler)

    crawl_request.reload
    expect(crawl_request.status).to eq("completed")
    expect(crawl_request.failure_message).to be_nil
  end

  it "updates the status to failed with the failure message when the crawl fails" do
    crawl_request = create(:crawl_request)
    crawler = mock_crawler_with(success: false, error: "500")

    described_class.perform_now(crawl_request.id, crawler)

    crawl_request.reload
    expect(crawl_request.status).to eq("failed")
    expect(crawl_request.failure_message).to eq("500")
  end

  def mock_crawler_with(result)
    crawler = instance_double("Crawlers::SimpleCrawler")
    allow(crawler).to receive(:fetch).and_return(result)
    crawler
  end
end
