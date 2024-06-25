class CreateWebPageDrafts < ActiveRecord::Migration[7.2]
  def change
    create_table :web_page_drafts do |t|
      t.string :title, null: false
      t.jsonb :body, default: {}, null: false
      t.references :crawl_request, null: true, foreign_key: true

      t.timestamps
    end
  end
end
