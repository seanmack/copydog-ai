module PageAnalysis
  # Extracts the title from an HTML document.

  class TitleExtractor
    def self.extract(doc)
      doc.at_css("title")&.text.presence
    end
  end
end
