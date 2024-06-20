# frozen_string_literal: true

class CrawlRequest < ApplicationRecord
  has_one_attached :html_response

  enum :status, { pending: 0, in_progress: 10, completed: 20, failed: 30 }

  validates :url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]), message: "must be a valid URL" }
  validates :status, presence: true

  store_accessor :analysis, :title
end
