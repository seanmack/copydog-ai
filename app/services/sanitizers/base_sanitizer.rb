module Sanitizers
  class BaseSanitizer
    DEFAULT_ELEMENTS_TO_REMOVE = %w[head script style]

    def sanitize
      raise NotImplementedError, "Subclasses must implement the sanitize method"
    end

    private

    def extract_inner_html(html_content:, element: "body")
      Sanitizers::Utilities::InnerHtmlExtractor.new(html_content:, element:).extract_inner_html
    end

    def remove_elements(html_content:, elements: DEFAULT_ELEMENTS_TO_REMOVE)
      Sanitizers::Utilities::ElementRemover.new(html_content:, elements:).remove_elements
    end

    def beautify(html_content:)
      Sanitizers::Utilities::Beautifier.new(html_content:).beautify
    end
  end
end
