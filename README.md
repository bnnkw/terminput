# terminput

Input buffer for a terminal window

- Command line editing in a normal buffer.
- Maps can be defined per command.

![terminput demo](https://raw.githubusercontent.com/bnnkw/terminput/refs/heads/demo/demo.gif)

## Installation

```vim
Plug 'bnnkw/terminput'
```

## Example Mapping

```vim
let g:terminput_mappings = #{
      \ bash: '<C-O>',
      \ fish: '<C-O>',
      \ zsh: '<C-O>',
      \ jshell: '<C-O>',
      \ node: '<C-O>',
      \ python3: '<C-O>',
      \ mysql: '<C-O>',
      \ psql: '<C-O>',
      \ sqlite3: '<C-O>',
      \ aider: '<C-J>',
      \ claude: '<C-J>',
      \ gemini-cli: '<C-J>'
      \}
```
