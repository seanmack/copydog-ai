class RemoveCrawlTypeFromCrawlRequests < ActiveRecord::Migration[7.2]
  def change
    remove_column :crawl_requests, :crawl_type, :integer
  end
end
