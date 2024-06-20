
FactoryBot.define do
  factory :crawl_request do
    url { "http://example.com" }
    status { :pending }
  end
end
