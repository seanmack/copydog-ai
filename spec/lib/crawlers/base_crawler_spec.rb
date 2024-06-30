require "rails_helper"

RSpec.describe Crawlers::BaseCrawler, type: :model do
  it "raises NotImplementedError when fetch is called" do
    crawler = Crawlers::BaseCrawler.new

    expect { crawler.fetch("http://example.com") }.to raise_error(
      NotImplementedError, "Subclasses must implement the fetch method"
    )
  end
end
