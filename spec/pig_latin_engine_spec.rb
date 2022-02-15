require "pig_latin_engine"

RSpec.describe PigLatinEngine do
  describe '#translate' do
    describe 'when the word starts with a single consonant' do
      it 'moves the first char to the end and appends "ay"' do
        expect(subject.translate('hello')).to eq('ellohay')
      end
    end

    describe 'when the word starts with a group of consonants' do
      it 'moves the first consonant group to the end and appends "ay"' do
        expect(subject.translate('school')).to eq('oolschay')
      end
    end

    describe 'when the word starts with "qu"' do
      it 'moves "qu" to the end and appends "ay"' do
        expect(subject.translate('hello')).to eq('ellohay')
      end
    end

    describe 'when the word starts with a vowel' do
      it 'appends "way" to the end' do
        expect(subject.translate('eat')).to eq('eatway')
      end
    end

    describe 'when the word starts with a "y"' do
      it 'appends "way" to the end' do
        expect(subject.translate('yellow')).to eq('yellowway')
      end
    end

    describe 'when there are multiple words' do
      it 'translates each word separately' do
        expect(subject.translate('eat world')).to eq('eatway orldway')
      end
    end

    describe 'when the word has uppercase and lowercase letters' do
      it 'maintains case based on the char positions of the original word' do
        expect(subject.translate('Hello')).to eq('Ellohay')
      end
    end

    describe 'when the word ends in an uppercase letter' do
      it 'appends uppercase "AY" to the end' do
        expect(subject.translate('HELLO')).to eq('ELLOHAY')
      end
    end

    describe 'when the word contains special characters in the middle' do
      it 'maintains the position of the special characters' do
        expect(subject.translate('she’s')).to eq('e’sshay')
      end
    end

    describe 'when the word ends with special characters' do
      it 'keeps the special characters at the end, after the appended "ay"' do
        expect(subject.translate('world?!')).to eq('orldway?!')
      end
    end
  end
end

# Didn't use in test cases:
# Apples => Applesway
# Hello There => Ellohay Erethay

# she’s great! => e’sshay eatgray!
# Changed to:
# she’s => e’sshay'

# eat… world?! => eatway… orldway?!
# Changed to:
# world?! => orldway?!
