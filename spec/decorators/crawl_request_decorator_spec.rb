require "rails_helper"

RSpec.describe CrawlRequestDecorator, type: :model do
  describe "#html" do
    context "when html_response is attached" do
      it "returns the html content" do
        crawl_request = setup_crawl_request_with_html
        decorator = described_class.new(crawl_request)

        expect(decorator.html).to eq("<html><body>Hello World</body></html>")
      end
    end

    context "when html_response is not attached" do
      it "returns nil" do
        crawl_request = create(:crawl_request)
        decorator = described_class.new(crawl_request)

        expect(decorator.html).to be_nil
      end
    end
  end

  describe "#sanitized_html" do
    context "when html_response is attached" do
      it "returns the sanitized html content" do
        crawl_request = setup_crawl_request_with_html
        decorator = described_class.new(crawl_request)

        sanitizer = instance_double(Sanitizers::SimpleSanitizer, sanitize: "Hello World")
        allow(Sanitizers::SimpleSanitizer).to receive(:new).with(html_content: "<html><body>Hello World</body></html>").and_return(sanitizer)

        expect(decorator.sanitized_html).to eq("Hello World")
      end
    end

    context "when html_response is not attached" do
      it "returns nil" do
        crawl_request = create(:crawl_request)
        decorator = described_class.new(crawl_request)

        expect(decorator.sanitized_html).to be_nil
      end
    end
  end

  def create_attached_blob(crawl_request, content)
    blob = ActiveStorage::Blob.create_and_upload!(
      io: StringIO.new(content),
      filename: "response.html",
      content_type: "text/html"
    )
    crawl_request.html_response.attach(blob)
  end

  def setup_crawl_request_with_html
    crawl_request = create(:crawl_request)
    create_attached_blob(crawl_request, "<html><body>Hello World</body></html>")
    crawl_request
  end
end
