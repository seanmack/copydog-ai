module Sanitizers
  module Utilities
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
