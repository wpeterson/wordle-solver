# world-solver

This is a dictionary file based tool for solving wordle word puzzles.  You can initialize a `WordList` instance from a dictionary file:

```
bin/wordle-shell
> list = WordList.all
> list.size
 => 15918
> list.without('quest').size
 => 3082
> list.match('..o..').size
 => 1154
