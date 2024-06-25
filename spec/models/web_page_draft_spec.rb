require "rails_helper"

RSpec.describe WebPageDraft, type: :model do
  describe "associations" do
    it { should belong_to(:crawl_request).optional }
  end

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }

    it "validates that body is valid JSON" do
      valid_json = build(:web_page_draft, body: '{"content": [{"title": "Section 1", "html": "<p>Content</p>"}]}')
      invalid_json = build(:web_page_draft, body: "invalid_json")

      expect(valid_json).to be_valid
      expect(invalid_json).not_to be_valid
      expect(invalid_json.errors[:body]).to include("must be valid JSON")
    end
  end
end
