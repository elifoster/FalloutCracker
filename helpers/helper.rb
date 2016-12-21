module Helper
  # @param str [String] The string
  # @return [Array<String>] A clean array of the string, split at newlines and with all empty strings stripped out
  def only_words(str)
    str.split(/[\n\r|]/).delete_if { |word| word.empty? }
  end
end
