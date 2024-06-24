FactoryBot.define do
  factory :crawl_request do
    url { "http://example.com" }
    status { :pending }

    trait :completed do
      status { :completed }
      after(:create) do |crawl_request|
        file = StringIO.new("<html><head><title>Test</title></head><body>Test content</body></html>")
        crawl_request.html_response.attach(io: file, filename: "test.html", content_type: "text/html")
      end
    end
  end
end
