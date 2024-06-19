module Crawlers
  class BaseCrawler
    def fetch(url)
      raise NotImplementedError, "Subclasses must implement the fetch method"
    end
  end
end
