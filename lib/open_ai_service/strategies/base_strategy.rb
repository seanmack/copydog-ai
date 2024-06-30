module OpenAiService
  module Strategies
    # Base class for OpenAI service strategies. See subclasses for usage.

    class BaseStrategy
      def prompt
        raise NotImplementedError, "Subclasses must implement the prompt method"
      end

      def content(data)
        raise NotImplementedError, "Subclasses must implement the content method"
      end
    end
  end
end
