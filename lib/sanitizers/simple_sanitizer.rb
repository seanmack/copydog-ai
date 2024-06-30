module Sanitizers
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
