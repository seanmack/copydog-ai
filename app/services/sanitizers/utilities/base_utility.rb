module Sanitizers
  module Utilities
    class BaseUtility
      attr_reader :html_content

      def initialize(html_content:)
        @html_content = html_content
      end
    end
  end
end
