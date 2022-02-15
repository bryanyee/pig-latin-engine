def translate(words)

end

def convert_word(word)

end

tests = [
  ['hello', 'ellohay'],
  ['eat', 'eatway'],
  ['yellow', 'yellowway'],
  ['eat world', 'eatway orldway'],
  ['Hello', 'Ellohay'],
  ['Apples', 'Applesway'],
  ['eat… world?!', 'eatway… orldway?!'],
  ['school', 'oolschay'],
  ['quick', 'ickquay'],
  ['she’s great!', 'e’sshay eatgray!'],
  ['HELLO', 'ELLOHAY'],
  ['Hello There', 'Ellohay Erethay']
]

tests.each do |test_pair|
  puts "word: #{test_pair[0]}, result: #{translate(test_pair[1])}, expected: #{test_pair[1]}"
end
