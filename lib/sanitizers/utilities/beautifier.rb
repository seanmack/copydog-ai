module Sanitizers
  module Utilities
    # Formats and normalizes HTML content using the HtmlBeautifier gem.

    class Beautifier < BaseUtility
      def beautify
        HtmlBeautifier.beautify(html_content)
      end
    end
  end
end
