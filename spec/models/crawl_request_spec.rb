require "rails_helper"

RSpec.describe CrawlRequest, type: :model do
  describe "columns" do
    it { should have_db_column(:analysis).of_type(:jsonb).with_options(default: {}) }
  end

  describe "associations" do
    it { should have_one_attached(:html_response) }
    it { should have_one(:web_page_draft) }
    it { should belong_to(:bulk_crawl_request).optional }
  end

  describe "validations" do
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:status) }
    it { should define_enum_for(:status).with_values(pending: 0, in_progress: 10, completed: 20, failed: 30) }

    it do
      should allow_values("http://example.com", "https://example.com").for(:url)
      should_not allow_values("example", "htp://example", "ftp://example.com").for(:url)
    end
  end

  describe "attachments" do
    it "can attach an HTML response" do
      crawl_request = create(:crawl_request)
      file = StringIO.new("<html></html>")
      crawl_request.html_response.attach(io: file, filename: "test.html", content_type: "text/html")

      expect(crawl_request.html_response).to be_attached
      expect(crawl_request.html_response.blob.filename).to eq("test.html")
    end
  end

  describe "store_accessor for analysis" do
    it "allows setting and getting the title" do
      crawl_request = create(:crawl_request)
      crawl_request.title = "Test Title"
      expect(crawl_request.title).to eq("Test Title")
    end

    it "allows setting and getting the meta_description" do
      crawl_request = create(:crawl_request)
      crawl_request.meta_description = "Test meta description"
      expect(crawl_request.meta_description).to eq("Test meta description")
    end
  end
end
