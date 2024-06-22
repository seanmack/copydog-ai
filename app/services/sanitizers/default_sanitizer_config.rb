module Sanitizers
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
