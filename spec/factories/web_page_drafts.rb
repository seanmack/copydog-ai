FactoryBot.define do
  factory :web_page_draft do
    title { "MyString" }
    body { "MyText" }
    crawl_request { nil }
  end
end
