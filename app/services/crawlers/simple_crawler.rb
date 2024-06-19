class Crawlers::SimpleCrawler < Crawlers::BaseCrawler
  def fetch(url)
    response = HTTParty.get(url)

    if response.success?
      { success: true, body: response.body }
    else
      { success: false, error: response.code }
    end
  rescue StandardError => e
    { success: false, error: e.message }
  end
end
