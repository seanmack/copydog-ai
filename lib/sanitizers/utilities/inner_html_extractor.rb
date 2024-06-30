module Sanitizers
  module Utilities
    # Extracts inner HTML from a specified element in the HTML content.
    #
    # @param html_content [String] the HTML content to extract from.
    # @param element [String] the CSS selector of the element to extract inner HTML from.
    # @return [String, nil] the inner HTML of the specified element, or nil if not found.
    #
    # @example
    #   extractor = Sanitizers::Utilities::InnerHtmlExtractor.new(html_content: '<html><body>Content</body></html>', element: 'body')
    #   inner_html = extractor.extract_inner_html # => 'Content'

    class InnerHtmlExtractor < BaseUtility
      attr_reader :element

      def initialize(html_content:, element:)
        super(html_content:)
        @element = element
      end

      def extract_inner_html
        doc = Nokogiri::HTML(html_content)
        node = doc.at_css(element)
        node ? node.inner_html : nil
      end
    end
  end
end
