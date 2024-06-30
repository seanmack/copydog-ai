module OpenAiService
  module Strategies
    # Strategy for extracting main content from HTML documents.
    # This strategy removes non-essential elements and formats the main content into sections.
    #
    # Example usage:
    #   strategy = OpenAiService::Strategies::ExtractMainContentStrategy.new
    #   prompt = strategy.prompt
    #   content = strategy.content(html_content: "<html>...</html>", sanitizer: CustomSanitizer)
    #
    # Parameters:
    # - html_content: The HTML content to process.
    # - sanitizer: The sanitizer class used to clean the HTML content (default is SimpleSanitizer).

    class ExtractMainContentStrategy < BaseStrategy
      def prompt
        <<~PROMPT.strip
          You are an assistant that processes HTML documents and extracts the main content. \
          Remove all non-essential elements such as navigation, advertisements, and footers. \
          Format the main content into sections with titles and paragraphs. Each title should be \
          put in an H2 tag, and the paragraphs should be put in P tags. HTML tags within the \
          body content should be preserved. Return the H2 tags and P tags only. Do not wrap the \
          content in any additional tags. Do not include backticks or code blocks.
        PROMPT
      end

      def content(html_content:, sanitizer: Sanitizers::SimpleSanitizer)
        sanitizer.new(html_content:).sanitize
      end
    end
  end
end
