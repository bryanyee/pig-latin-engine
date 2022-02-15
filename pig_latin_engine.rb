require 'set'

VOWELS = %w(a e i o u y)
VOWELS_SET = Set.new(VOWELS)

def translate(string)
  words = string.split()
  translated_words = words.map { |word| convert_word(word) }
  translated_words.join(' ')
end

# TODO: handle special characters
def convert_word(word)
  char_array = word.split('')
  result_array = []
  first_vowel_position = char_array.index { |char| is_vowel(char) }

  # Step 1 - Reorganize characters
  # Case 1: First characters are `qu`
  if word[0] === 'q' && word[1] === 'u'
    result_array = char_array.slice(2, char_array.size - 2).concat(['q', 'u'])
  # Case 2: First character(s) are consonants
  elsif first_vowel_position > 0
    consonant_group = char_array.slice(0, first_vowel_position)
    remaining_word = char_array.slice(first_vowel_position, char_array.size - first_vowel_position)
    result_array = remaining_word.concat(consonant_group)
  # Case 3: First character is a vowel
  else
    result_array = char_array.dup().concat(['w'])
  end

  # Step 2 - Pass through each character and set the appropriate casing
  char_array.each_index do |index|
    char = char_array[index]
    result_array[index] = if is_upcase(char)
      result_array[index].upcase()
    else
      result_array[index].downcase()
    end
  end

  # Step 3 - Append `ay`
  last_char = word[word.size-1]
  if is_upcase(last_char)
    result_array.concat(['A', 'Y'])
  else
    result_array.concat(['a', 'y'])
  end

  result_array.join()
end

def is_vowel(char)
  VOWELS_SET.include?(char) || VOWELS_SET.include?(char.downcase())
end

def is_upcase(char)
  char == char.upcase()
end

tests = [
  ['hello', 'ellohay'], # PASS
  ['eat', 'eatway'], # PASS
  ['yellow', 'yellowway'], # PASS
  ['eat world', 'eatway orldway'], # PASS
  ['Hello', 'Ellohay'], # PASS
  ['Apples', 'Applesway'], # PASS
  ['eat… world?!', 'eatway… orldway?!'],
  ['school', 'oolschay'], # PASS
  ['quick', 'ickquay'], # PASS
  ['she’s great!', 'e’sshay eatgray!'],
  ['HELLO', 'ELLOHAY'], # PASS
  ['Hello There', 'Ellohay Erethay'] # PASS
]

tests.each do |test_pair|
  word = test_pair[0]
  result = translate(word)
  expected = test_pair[1]
  passing = result == expected ? 'T' : 'F'
  puts "passing: #{passing}, word: #{word}, result: #{result}, expected: #{expected}"
end
