## Logic
```
Outer func:
  Split words by whitespace
  Process each word
  Join the results and return

Translate word func:
  If word ends with special chars, strip them off (to add back later)

  If word starts w/ `qu`
    Move `qu` to the end
  If word starts w/ consonant
    Move first group of consonants to end
  Else (starts w/ vowel)
    Append `w` at the end
  
  Pass through each character
    Set casing of each character to match the corresponding position of the original string
    Match the casing of the appended characters in the result to the last character of the original string

  Append `ay` at the end w/ the correct casing

  If original word ended with special chars, add them back

  Return the result
```

## Rules / Test Cases

1. Start w/ consonant:
  - Move first character to end, and add `ay`
    - e.g. hello => ellohay

  - If there are a group of consonants af the beginning, move the whole group to the end of the result, and add `ay`
    - e.g. school => oolschay

  - If the first characters are a `qu`, move `qu` to the end, and add `ay`
    - e.g. quick => ickquay

2. Start w/ vowel (including `y`):
  - Add `way` at the end
    - e.g. eat => eatway
    - e.g. yellow => yellowway

Other rules:
  - **Multiple words:** If the strings contains multiple words (separated by whitespace), then process each word individually
    - e.g. eat world => eatway orldway

  - **Casing**: Upper/lower casing must be preserved by position
    - e.g. Hello => Ellohay
    - e.g. Apples => Applesway
    - e.g. Hello There => Ellohay Erethay

  - **Casing**: The casing of the last character of the original character set the casing for the appended characters at the end of the result
    - e.g. HELLO => ELLOHAY

  - **Special characters**: If the word ends w/ special characters, keep the special characters at the end of the result
    - e.g. eat… world?! => eatway… orldway?!

  - **Special characters**: If the word contains special characters, preserve their position relative to the characters in the original string
    - e.g. she’s great! => e’sshay eatgray!
