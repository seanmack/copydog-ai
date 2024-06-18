require "rails_helper"

RSpec.describe CrawlRequest, type: :model do
  describe "validations" do
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:crawl_type) }
    it { should validate_presence_of(:status) }

    it { should define_enum_for(:crawl_type).with_values([:single_page, :entire_site]) }
    it { should define_enum_for(:status).with_values([:pending, :in_progress, :completed, :failed]) }

    it do
      should allow_values("http://example.com", "https://example.com").for(:url)
      should_not allow_values("example", "htp://example", "ftp://example.com").for(:url)
    end
  end
end
