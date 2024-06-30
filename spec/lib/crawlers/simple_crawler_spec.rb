require "rails_helper"

RSpec.describe Crawlers::SimpleCrawler, type: :model do
  it "returns success with body and status when the response is successful" do
    stub_request(:get, "http://example.com").to_return(status: 200, body: "<html></html>")

    crawler = Crawlers::SimpleCrawler.new
    result = crawler.fetch("http://example.com")

    expect(result).to eq({ success: true, body: "<html></html>" })
  end

  it "returns failure with status when the response is unsuccessful" do
    stub_request(:get, "http://example.com").to_return(status: 500)

    crawler = Crawlers::SimpleCrawler.new
    result = crawler.fetch("http://example.com")

    expect(result).to eq({ success: false, error: 500 })
  end

  it "returns failure with error message when a StandardError is raised" do
    allow(HTTParty).to receive(:get).and_raise(StandardError.new("Something went wrong"))

    crawler = Crawlers::SimpleCrawler.new
    result = crawler.fetch("http://example.com")

    expect(result).to eq({ success: false, error: "Something went wrong" })
  end
end
