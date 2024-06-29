class CrawlRequestDecorator
  def initialize(crawl_request)
    @crawl_request = crawl_request
  end

  def html
    return unless html_response?

    @html ||= @crawl_request.html_response.open do |file|
      File.read(file)
    end
  end

  def sanitized_html
    return unless html_response?

    Sanitizers::SimpleSanitizer.new(html_content: html).sanitize
  end

  private

  def html_response?
    @crawl_request.html_response.attached?
  end
end
