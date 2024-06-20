require "rails_helper"

RSpec.describe CrawlWebPageJob, type: :job do
  it "updates the status to completed when the crawl is successful and attaches the HTML response" do
    crawl_request = create(:crawl_request)
    crawler = mock_crawler_with(success: true, body: "<html></html>")

    described_class.perform_now(crawl_request.id, crawler)

    crawl_request.reload
    expect(crawl_request.status).to eq("completed")
    expect(crawl_request.failure_message).to be_nil
    expect(crawl_request.html_response.attached?).to be true

    html_response = crawl_request.html_response.download
    expect(html_response).to eq("<html></html>")
  end

  it "updates the status to failed with the failure message when the crawl fails" do
    crawl_request = create(:crawl_request)
    crawler = mock_crawler_with(success: false, error: "500")

    described_class.perform_now(crawl_request.id, crawler)

    crawl_request.reload
    expect(crawl_request.status).to eq("failed")
    expect(crawl_request.failure_message).to eq("500")
    expect(crawl_request.html_response.attached?).to be false
  end

  it "purges the existing attachment before attaching a new one" do
    crawl_request = create(:crawl_request)
    first_crawler = mock_crawler_with(success: true, body: "<html>First</html>")
    second_crawler = mock_crawler_with(success: true, body: "<html>Second</html>")

    # First time
    described_class.perform_now(crawl_request.id, first_crawler)
    crawl_request.reload
    first_attachment = crawl_request.html_response.download
    expect(first_attachment).to eq("<html>First</html>")

    # Second time
    described_class.perform_now(crawl_request.id, second_crawler)
    crawl_request.reload
    second_attachment = crawl_request.html_response.download
    expect(second_attachment).to eq("<html>Second</html>")
  end

  it "extracts and saves the title from the HTML response" do
    crawl_request = create(:crawl_request)
    crawler = mock_crawler_with(success: true, body: "<html><head><title>Test Title</title></head><body></body></html>")

    described_class.perform_now(crawl_request.id, crawler)

    crawl_request.reload
    expect(crawl_request.title).to eq("Test Title")
  end

  def mock_crawler_with(result)
    crawler = instance_double("Crawlers::SimpleCrawler")
    allow(crawler).to receive(:fetch).and_return(result)
    crawler
  end
end
