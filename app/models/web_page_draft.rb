class WebPageDraft < ApplicationRecord
  belongs_to :crawl_request, optional: true

  validates :title, presence: true
end
