class PageAnalysis
  attr_reader :content, :title

  def initialize(content:)
    @content = content
    analyze
  end

  private

  def analyze
    doc = Nokogiri::HTML(content)
    @title = extract_title(doc)
  end

  def extract_title(doc)
    doc.at_css("title")&.text.presence
  end
end
