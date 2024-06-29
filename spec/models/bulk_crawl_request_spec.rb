require "rails_helper"

RSpec.describe BulkCrawlRequest, type: :model do
  it { should have_many(:crawl_requests) }
end
