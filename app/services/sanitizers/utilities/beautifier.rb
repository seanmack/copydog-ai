module Sanitizers
  module Utilities
    class Beautifier < BaseUtility
      def beautify
        HtmlBeautifier.beautify(html_content)
      end
    end
  end
end
