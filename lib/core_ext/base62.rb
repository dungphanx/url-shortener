module Base62
  BASE62_ALPHABET = ('0'..'9').to_a + ('A'..'Z').to_a + ('a'..'z').to_a

  class << self
    def encode(number)
      return BASE62_ALPHABET[0] if number.zero?

      result = ''
      base = BASE62_ALPHABET.length

      while number > 0
        result << BASE62_ALPHABET[number % base]
        number /= base
      end

      result
    end

    def decode(string)
      result = 0

      string.chars.each_with_index do |char, index|
        result += BASE62_ALPHABET.index(char) * (BASE62_ALPHABET.size**index)
      end

      result
    end
  end
end