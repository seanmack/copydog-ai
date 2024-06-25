require "rails_helper"

RSpec.describe WebPageDraft, type: :model do
  describe "associations" do
    it { should belong_to(:crawl_request).optional }
  end

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
  end
end
