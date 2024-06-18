
FactoryBot.define do
  factory :crawl_request do
    url { "http://example.com" }
    crawl_type { :single_page }
    status { :pending }

    trait :single_page do
      crawl_type { :single_page }
    end

    trait :entire_site do
      crawl_type { :entire_site }
    end

    trait :pending do
      status { :pending }
    end

    trait :in_progress do
      status { :in_progress }
    end

    trait :completed do
      status { :completed }
    end

    trait :failed do
      status { :failed }
    end
  end
end
