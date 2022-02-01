require 'word_list'

RSpec.describe WordList do
  let(:word_list_file) { File.join(File.dirname(__FILE__), 'fixtures/word_list.txt') }
  let(:words) { %w(alpha beta gamma) }

  describe 'initalizer' do
    let(:words) { %w(a b c) }

    it 'wraps a word list array' do
      list = described_class.new(words)

      expect(list.words).to eq(words)
    end
  end

  describe '.from_file' do
    it 'loads all words from a file' do
      list = described_class.from_file(word_list_file)

      expect(list.words).to eq(words)
    end
  end

  describe '#is_valid?' do
    let(:list) { described_class.from_file(word_list_file) }

    it 'is true if word is included' do
      expect(list.is_valid?('alpha')).to eq(true)
      expect(list.is_valid?('ALPHA')).to eq(true)
      expect(list.is_valid?('beta')).to eq(true)
      expect(list.is_valid?('gamma')).to eq(true)
    end

    it 'is false if word is not included' do
      expect(list.is_valid?('not-included')).to eq(false)
      expect(list.is_valid?('alpha-not-included')).to eq(false)
    end
  end

  describe '#each' do
    let(:list) { described_class.from_file(word_list_file) }

    it 'enumerates all words' do
      expect(list.each.to_a).to eq(words)
    end
  end

  describe 'size' do
    let(:list) { described_class.from_file(word_list_file) }

    it 'delegates to word list array size' do
      expect(list.size).to eq(3)
      expect(list.size).to eq(list.words.size)
    end
  end

  describe 'with' do
    let(:list) { described_class.from_file(word_list_file) }

    it 'returns new list of words filtered to only those with ALL given letters' do
      expect(list.words).to eq(words)

      expect(list.with('p').words).to eq(%w(alpha))
      expect(list.with('ap').words).to eq(%w(alpha))
    end
  end

  describe 'without' do
    let(:list) { described_class.from_file(word_list_file) }

    it 'returns new list of words filtered to only those without ANY given letters' do
      expect(list.words).to eq(words)

      expect(list.without('a').words).to eq(%w())
      expect(list.without('p').words).to eq(%w(beta gamma))
    end
  end

  describe 'match' do
    let(:list) { described_class.from_file(word_list_file) }

    it 'returns new list of words filtered to only those matching regex' do
      expect(list.words).to eq(words)

      expect(list.match(/\w{6}/).words).to eq(%w())
      expect(list.match(/.*a$/).words).to eq(%w(alpha beta gamma))
    end
  end
end
