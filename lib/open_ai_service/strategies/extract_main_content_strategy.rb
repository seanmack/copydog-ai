module OpenAiService
  module Strategies
    class ExtractMainContentStrategy < BaseStrategy
      def prompt
        <<~PROMPT.strip
          You are an assistant that processes HTML documents and extracts the main content. \
          Remove all non-essential elements such as navigation, advertisements, and footers. \
          Format the main content into sections with titles and paragraphs. The title should be \
          put in an H2 tag, and the paragraphs should be put in P tags. HTML tags within the \
          body content should be preserved. Return the result as a JSON array of objects. Each \
          object should have a title attribute pointing to a string that represents the title of \
          the section, and a content attribute pointing to an HTML string containing p tags.
        PROMPT
      end

      def content(html_content:, sanitizer: Sanitizers::SimpleSanitizer)
        sanitizer.new(html_content:).sanitize
      end
    end
  end
end
