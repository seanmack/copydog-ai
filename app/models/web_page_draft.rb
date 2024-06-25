class WebPageDraft < ApplicationRecord
  belongs_to :crawl_request, optional: true

  validates :title, presence: true
  validates :body, presence: true
end
