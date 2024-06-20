class AddAnalysisToCrawlRequests < ActiveRecord::Migration[7.2]
  def change
    add_column :crawl_requests, :analysis, :jsonb, default: {}
  end
end
