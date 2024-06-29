# Converts a string into an array of items

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
