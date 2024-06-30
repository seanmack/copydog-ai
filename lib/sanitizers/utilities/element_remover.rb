module Sanitizers
  module Utilities
    # Removes specified elements and attributes from HTML content based on a configuration.
    #
    # @param html_content [String] the HTML content to be sanitized.
    # @param config [Hash] the configuration for element removal (optional).
    # @return [String] the HTML content with specified elements removed.
    #
    # @example
    #   remover = Sanitizers::Utilities::ElementRemover.new(html_content: '<html>...</html>')
    #   cleaned_content = remover.remove_elements # => sanitized HTML content

    class ElementRemover < BaseUtility
      attr_reader :config

      def initialize(html_content:, config: DEFAULT_SANITIZER_CONFIG)
        super(html_content:)
        @config = config
      end

      def remove_elements
        Sanitize.fragment(html_content, config)
      end

      # Default configuration for the ElementRemover utility. These settings
      # are a good starting point for most sanitization tasks, but we will
      # likely need to customize them for specific use cases.
      DEFAULT_SANITIZER_CONFIG = {
        # Remove all elements except the following:
        elements: %w[div span p a ul ol li],

        # Remove all attributes except the following:
        attributes: {
          "a" => %w[href]
        },

        # Remove all protocols except the following:
        protocols: {
          "a" => { "href" => ["http", "https"] }
        },

        # Remove empty nodes and nodes with only whitespace
        transformers: lambda do |env|
          node = env[:node]
          return unless node.elem?

          unless node.children.any? { |c| !c.text? || c.content.strip.length > 0 }
            node.unlink
          end
        end
      }
    end
  end
end
