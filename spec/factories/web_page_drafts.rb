FactoryBot.define do
  factory :web_page_draft do
    title { "MyString" }
    body { '{"content": [{"title": "Section 1", "html": "<p>Content</p>"}]}' }
    crawl_request { nil }
  end
end
