# world-solver

This is a dictionary file based tool for solving wordle word puzzles.  You can initialize a `WordList` instance from a dictionary file:

```
require_relative 'lib/word_list'
list = WordList.from_file('./data/5letter_alpha.txt')
list.size
 => 15918
list.without_letters('quest').size
 => 3082
list.filter('..o..').size
 => 1154
