module Sanitizers
  # Sanitizes HTML content by extracting inner HTML, removing elements, and beautifying the content.
  #
  # @param html_content [String] the HTML content to be sanitized.
  # @return [String] the sanitized HTML content.
  #
  # @example
  #   sanitizer = Sanitizers::SimpleSanitizer.new(html_content: '<html>...</html>')
  #   sanitized_content = sanitizer.sanitize # => sanitized HTML content

  class SimpleSanitizer < BaseSanitizer
    attr_reader :html_content

    def initialize(html_content:)
      @html_content = html_content
    end

    def sanitize
      result = extract_inner_html(html_content:)
      result = remove_elements(html_content: result)
      result = beautify(html_content: result)
      result
    end
  end
end
