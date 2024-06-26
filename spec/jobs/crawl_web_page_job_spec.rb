require "rails_helper"

RSpec.describe CrawlWebPageJob, type: :job do
  before do
    stub_send_content_for_analysis
  end

  it "updates the status to completed when the crawl is successful and attaches the HTML response" do
    crawl_request = create(:crawl_request)
    crawler = mock_crawler(success: true, body: "<html></html>")

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
    crawler = mock_crawler(success: false, error: "500")

    described_class.perform_now(crawl_request.id, crawler)

    crawl_request.reload
    expect(crawl_request.status).to eq("failed")
    expect(crawl_request.failure_message).to eq("500")
    expect(crawl_request.html_response.attached?).to be false
  end

  it "purges the existing attachment before attaching a new one" do
    crawl_request = create(:crawl_request)
    first_crawler = mock_crawler(success: true, body: "<html>First</html>")
    second_crawler = mock_crawler(success: true, body: "<html>Second</html>")

    described_class.perform_now(crawl_request.id, first_crawler)
    crawl_request.reload
    first_attachment = crawl_request.html_response.download
    expect(first_attachment).to eq("<html>First</html>")

    described_class.perform_now(crawl_request.id, second_crawler)
    crawl_request.reload
    second_attachment = crawl_request.html_response.download
    expect(second_attachment).to eq("<html>Second</html>")
  end

  it "extracts and saves the title from the HTML response" do
    crawl_request = create(:crawl_request)
    crawler = mock_crawler(success: true)
    parser = mock_parser(title: "Test Title")
    allow(PageAnalysis::Parser).to receive(:new).and_return(parser)

    described_class.perform_now(crawl_request.id, crawler)

    crawl_request.reload
    expect(crawl_request.title).to eq("Test Title")
  end

  it "extracts and saves the meta description from the HTML response" do
    crawl_request = create(:crawl_request)
    crawler = mock_crawler(success: true)
    parser = mock_parser(meta_description: "Test Description")
    allow(PageAnalysis::Parser).to receive(:new).and_return(parser)

    described_class.perform_now(crawl_request.id, crawler)

    crawl_request.reload
    expect(crawl_request.meta_description).to eq("Test Description")
  end

  it "calls SendContentForAnalysis and creates a WebPageDraft" do
    crawl_request = create(:crawl_request)
    crawler = mock_crawler(success: true, body: "<html></html>")
    parser = mock_parser(title: "Test Title", meta_description: "Test Description")
    allow(PageAnalysis::Parser).to receive(:new).and_return(parser)

    described_class.perform_now(crawl_request.id, crawler)

    expect(SendContentForAnalysis).to have_received(:new).with(html: "<html></html>")
    expect(WebPageDraft.last.title).to eq("Test Title")
  end

  def mock_crawler(result = {})
    default_result = { success: true, body: "", error: nil }
    instance_double("Crawlers::SimpleCrawler", fetch: default_result.merge(result))
  end

  def mock_parser(attributes = {})
    defaults = { title: nil, meta_description: nil }
    instance_double("PageAnalysis::Parser", defaults.merge(attributes))
  end

  def stub_send_content_for_analysis
    response = [{ "title" => "Section 1", "html" => "<p>Content</p>" }]
    allow(SendContentForAnalysis).to receive(:new).and_return(instance_double(SendContentForAnalysis, call: response))
  end
end
