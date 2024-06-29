# spec/jobs/crawl_web_pages_job_spec.rb
require "rails_helper"

RSpec.describe CrawlWebPagesJob, type: :job do
  describe "#perform" do
    it "extracts URLs from the bulk_crawl_request" do
      bulk_crawl_request = create_bulk_crawl_request(urls: "http://example.com\nhttp://test.com")
      job = CrawlWebPagesJob.new

      allow(job).to receive(:create_crawl_requests)
      allow(job).to receive(:trigger_crawl_jobs)

      expect(TextListParser).to receive(:new).with(text_list: bulk_crawl_request.urls).and_call_original
      job.perform(bulk_crawl_request.id)
    end

    it "creates crawl requests for each URL" do
      bulk_crawl_request = create_bulk_crawl_request(urls: "http://example.com\nhttp://test.com")
      urls = ["http://example.com", "http://test.com"]
      job = CrawlWebPagesJob.new

      allow(job).to receive(:trigger_crawl_jobs)

      expect {
        job.perform(bulk_crawl_request.id)
      }.to change { CrawlRequest.count }.by(2)

      urls.each do |url|
        expect(CrawlRequest.exists?(url:, bulk_crawl_request:)).to be true
      end
    end

    it "logs an error if a CrawlRequest is invalid" do
      bulk_crawl_request = create_bulk_crawl_request(urls: "invalid-url")
      job = CrawlWebPagesJob.new

      allow(job).to receive(:trigger_crawl_jobs)

      expect(Rails.logger).to receive(:error).with("Failed to create CrawlRequest for URL: invalid-url")
      job.perform(bulk_crawl_request.id)
    end

    it "triggers crawl jobs for each CrawlRequest" do
      bulk_crawl_request = create_bulk_crawl_request(urls: "http://example.com\nhttp://test.com")
      job = CrawlWebPagesJob.new

      expect(CrawlWebPageJob).to receive(:perform_later).twice
      job.perform(bulk_crawl_request.id)
    end
  end

  def create_bulk_crawl_request(urls:)
    BulkCrawlRequest.create(urls: urls)
  end
end
