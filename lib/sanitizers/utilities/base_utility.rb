module Sanitizers
  module Utilities
    # Base class for utility classes used in sanitizing HTML content.
    # See subclasses for usage.

    class BaseUtility
      attr_reader :html_content

      def initialize(html_content:)
        @html_content = html_content
      end
    end
  end
end
