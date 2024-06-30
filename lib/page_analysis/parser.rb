module PageAnalysis
  # Parses HTML content to extract the title and meta description.
  #
  # @param content [String] the HTML content to be analyzed.
  #
  # @example
  #   parser = PageAnalysis::Parser.new(content: '<html>...</html>')
  #   parser.title # => 'Page Title'
  #   parser.meta_description # => 'Page meta description'

  class Parser
    attr_reader :content, :title, :meta_description

    def initialize(content:)
      @content = content
      analyze
    end

    private

    def analyze
      doc = Nokogiri::HTML(content)
      @title = TitleExtractor.extract(doc)
      @meta_description = MetaDescriptionExtractor.extract(doc)
    end
  end
end
