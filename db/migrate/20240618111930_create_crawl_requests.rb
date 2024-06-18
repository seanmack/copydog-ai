class CreateCrawlRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :crawl_requests do |t|
      t.string :url, null: false
      t.integer :crawl_type, null: false
      t.integer :status, null: false, default: 0
      t.timestamps
    end
  end
end
