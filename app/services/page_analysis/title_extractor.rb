module PageAnalysis
  class TitleExtractor
    def self.extract(doc)
      doc.at_css("title")&.text.presence
    end
  end
end
