require 'algorithms'

class WordList
  attr_reader :words

  WORD_FILE = File.join(File.dirname(__FILE__), '../data/wordle_sorted_words.txt')

  def initialize(words)
    @words = words
  end

  def self.all
    from_file(WORD_FILE)
  end

  def self.from_file(path)
    new(File.open(path) { |file| file.each.map {|line| line.chomp.downcase } })
  end

  def is_valid?(word)
    prefix_trie.has_key?(word.downcase)
  end

  def each
    words.each
  end

  def size
    words.size
  end

  def without(letters)
    letters = letters.chars if letters.is_a?(String)
    letters_regex = /(#{letters.join('|')})/

    self.class.new(words.select {|word| !word.match(letters_regex) })
  end

  def with(letters)
    letters = letters.chars if letters.is_a?(String)
    letters_regex = Regexp.new letters.map {|l| "(?=.*#{l})" }.join

    match(letters_regex)
  end

  def match(regex)
    self.class.new(words.select {|word| word.match(regex) })
  end

private

  def prefix_trie
    @prefix_trie ||= Containers::Trie.new.tap { |trie| words.each { |word| trie.push(word, word) } }
  end
end
