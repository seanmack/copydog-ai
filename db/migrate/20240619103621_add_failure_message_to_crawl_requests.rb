class AddFailureMessageToCrawlRequests < ActiveRecord::Migration[7.2]
  def change
    add_column :crawl_requests, :failure_message, :string
  end
end
