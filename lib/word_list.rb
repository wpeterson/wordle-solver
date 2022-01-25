require 'algorithms'

class WordList
  attr_reader :words

  WORD_FILE = File.join(File.dirname(__FILE__), '../data/5letter_alpha.txt')

  def initialize(words)
    @words = words
  end

  def self.wordle_words
    from_file(WORD_FILE)
  end

  def self.from_file(path)
    new(File.open(path) { |file| file.each.map {|line| line.chomp } })
  end

  def is_valid?(word)
    prefix_trie.has_key?(word)
  end

  def each
    words.each
  end

  def size
    words.size
  end

  def without_letters(letters)
    letters_regex = regex_for_letters(letters)
    self.class.new(words.select {|word| !word.match(letters_regex) })
  end

  def with_letters(letters)
    letters_regex = regex_for_letters(letters)
    self.class.new(words.select {|word| word.match(letters_regex) })
  end

  def filter(pattern)
    self.class.new(prefix_trie.wildcard(pattern))
  end

private

  def regex_for_letters(letters)
    letters = letters.chars if letters.is_a?(String)

    /(#{letters.join('|')})/
  end

  def prefix_trie
    @prefix_trie ||= Containers::Trie.new.tap { |trie| words.each { |word| trie.push(word, word) } }
  end
end
