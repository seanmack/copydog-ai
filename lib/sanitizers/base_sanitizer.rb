module Sanitizers
  # Base class for sanitizing HTML content. See subclasses for usage.

  class BaseSanitizer
    def sanitize
      raise NotImplementedError, "Subclasses must implement the sanitize method"
    end

    private

    def extract_inner_html(html_content:, element: "body")
      Sanitizers::Utilities::InnerHtmlExtractor.new(html_content:, element:).extract_inner_html
    end

    def remove_elements(html_content:)
      Sanitizers::Utilities::ElementRemover.new(html_content:).remove_elements
    end

    def beautify(html_content:)
      Sanitizers::Utilities::Beautifier.new(html_content:).beautify
    end
  end
end
