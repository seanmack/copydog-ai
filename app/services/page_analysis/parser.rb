module PageAnalysis
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
