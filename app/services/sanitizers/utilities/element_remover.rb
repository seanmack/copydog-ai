module Sanitizers
  module Utilities
    class ElementRemover < BaseUtility
      attr_reader :elements

      def initialize(html_content:, elements:)
        super(html_content:)
        @elements = elements
      end

      def remove_elements
        doc = Nokogiri::HTML.fragment(html_content)

        elements.each do |element|
          doc.css(element).remove
        end

        doc.to_html
      end
    end
  end
end
