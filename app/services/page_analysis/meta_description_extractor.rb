module PageAnalysis
  class MetaDescriptionExtractor
    def self.extract(doc)
      meta_tag = doc.at_css("meta[name='description']")
      return if !meta_tag

      meta_tag.attributes["content"].value.presence
    end
  end
end
