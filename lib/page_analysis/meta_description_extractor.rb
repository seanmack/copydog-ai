module PageAnalysis
  # Extracts the meta description from an HTML document. See
  # PageAnalysis::Parser for usage.

  class MetaDescriptionExtractor
    def self.extract(doc)
      meta_tag = doc.at_css("meta[name='description']")
      return if !meta_tag

      meta_tag.attributes["content"].value.presence
    end
  end
end
