require "rails_helper"

RSpec.describe OpenAiService::Strategies::BaseStrategy do
  let(:strategy) { described_class.new }

  describe "#prompt" do
    it "raises NotImplementedError" do
      expect { strategy.prompt }.to raise_error(NotImplementedError, "Subclasses must implement the prompt method")
    end
  end

  describe "#content" do
    it "raises NotImplementedError" do
      expect { strategy.content(data: "some data") }.to raise_error(NotImplementedError, "Subclasses must implement the content method")
    end
  end
end
