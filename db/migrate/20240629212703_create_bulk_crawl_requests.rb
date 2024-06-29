class CreateBulkCrawlRequests < ActiveRecord::Migration[7.2]
  def change
    create_table :bulk_crawl_requests do |t|
      t.text :urls
      t.timestamps
    end
  end
end
