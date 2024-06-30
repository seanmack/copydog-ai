# Parses a list of text items separated by newlines.
#
# @param text_list [String] The text containing newline-separated items.
#
# @example
#   parser = TextListParser.new(text_list: "item1\nitem2\nitem3")
#   items = parser.items
#   # items => ["item1", "item2", "item3"]
#
# @return [Array<String>] An array of stripped, non-empty items.

class TextListParser
  attr_reader :text_list

  def initialize(text_list:)
    @text_list = text_list
  end

  def items
    return [] unless text_list.present?

    text_list.split("\n").map(&:strip).reject(&:empty?)
  end
end
