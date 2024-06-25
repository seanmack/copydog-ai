class WebPageDraft < ApplicationRecord
  belongs_to :crawl_request, optional: true

  validates :title, presence: true
  validates :body, presence: true
  validate :body_must_be_valid_json

  private

  def body_must_be_valid_json
    JSON.parse(body) if body.present?
  rescue JSON::ParserError
    errors.add(:body, "must be valid JSON")
  end
end
