require_relative "../default_sanitizer_config"

module Sanitizers
  module Utilities
    class ElementRemover < BaseUtility
      attr_reader :config

      def initialize(html_content:, config: Sanitizers::DEFAULT_SANITIZER_CONFIG)
        super(html_content:)
        @config = config
      end

      def remove_elements
        Sanitize.fragment(html_content, config)
      end
    end
  end
end
