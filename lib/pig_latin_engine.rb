require 'set'

VOWELS = %w(a e i o u y)
VOWELS_SET = Set.new(VOWELS)

class PigLatinEngine
  def translate(string)
    words = string.split
    translated_words = words.map { |word| convert_word(word) }
    translated_words.join(' ')
  end
  
  # Alternative for refactor: split each step of operations into smaller methods,
  # potentially w/ chaining or yield blocks
  private def convert_word(word)
    char_array = word.split('')
    result_array = []
    first_vowel_position = char_array.index { |char| vowel?(char) }
  
    # Step 1 - Strip off special characters at the end, to add back later
    special_char_suffix_array = []
    while !letter?(char_array[char_array.size-1])
      non_letter_char = char_array.pop
      special_char_suffix_array.push(non_letter_char)
    end
    special_char_suffix_array.reverse!
  
    # Step 2 - Reorganize characters
    # Case 1: First characters are `qu`
    if word[0] === 'q' && word[1] === 'u'
      result_array = char_array.slice(2, char_array.size - 2).concat(['q', 'u'])
    # Case 2: First character(s) are consonants
    elsif first_vowel_position > 0
      consonant_group = char_array.slice(0, first_vowel_position)
      remaining_word = char_array.slice(first_vowel_position, char_array.size - first_vowel_position)
      result_array = remaining_word.dup().concat(consonant_group)
    # Case 3: First character is a vowel
    else
      result_array = char_array.dup().concat(['w'])
    end
  
    # Step 3 - Pass through each character and set the appropriate casing
    char_array.each_index do |index|
      char = char_array[index]
      result_array[index] = if upcase?(char)
        result_array[index].upcase
      else
        result_array[index].downcase
      end
    end
  
    # Step 4 - Append `ay`
    last_char = word[word.size-1]
    if upcase?(last_char)
      result_array.concat(['A', 'Y'])
    else
      result_array.concat(['a', 'y'])
    end
  
    # Step 5 - Add back special characters at the end of the word, if any
    result_array.concat(special_char_suffix_array)
  
    # Return
    result_array.join
  end
end

def vowel?(char)
  VOWELS_SET.include?(char) || VOWELS_SET.include?(char.downcase)
end

def upcase?(char)
  letter?(char) && char == char.upcase
end

def letter?(char)
  !char.match(/[a-zA-Z]/).nil?
end

# tests = [
#   ['hello', 'ellohay'], # PASS
#   ['eat', 'eatway'], # PASS
#   ['yellow', 'yellowway'], # PASS
#   ['eat world', 'eatway orldway'], # PASS
#   ['Hello', 'Ellohay'], # PASS
#   ['Apples', 'Applesway'], # PASS
#   ['eat… world?!', 'eatway… orldway?!'], # PASS
#   ['school', 'oolschay'], # PASS
#   ['quick', 'ickquay'], # PASS
#   ['she’s great!', 'e’sshay eatgray!'], # PASS
#   ['HELLO', 'ELLOHAY'], # PASS
#   ['Hello There', 'Ellohay Erethay'] # PASS
# ]

# tests.each do |test_pair|
#   word = test_pair[0]
#   result = translate(word)
#   expected = test_pair[1]
#   passing = result == expected ? 'T' : 'F'
#   puts "passing: #{passing}, word: #{word}, result: #{result}, expected: #{expected}"
# end
