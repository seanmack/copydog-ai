module Sanitizers
  module Utilities
    class ElementRemover < BaseUtility
      attr_reader :config

      def initialize(html_content:, config: DEFAULT_SANITIZER_CONFIG)
        super(html_content:)
        @config = config
      end

      def remove_elements
        Sanitize.fragment(html_content, config)
      end

      DEFAULT_SANITIZER_CONFIG = {
        elements: %w[div span p a ul ol li],
        attributes: {
          "a" => %w[href]
        },
        protocols: {
          "a" => { "href" => ["http", "https"] }
        },
        transformers: lambda do |env|
          node = env[:node]
          return unless node.elem?

          # Remove empty nodes
          unless node.children.any? { |c| !c.text? || c.content.strip.length > 0 }
            node.unlink
          end
        end
      }
    end
  end
end
