class AddBulkCrawlRequestIdToCrawlRequests < ActiveRecord::Migration[7.2]
  def change
    add_reference :crawl_requests, :bulk_crawl_request, null: true, foreign_key: true
  end
end
