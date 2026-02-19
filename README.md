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
let g:terminput_config = #{
      \ bash: #{
      \   key: '<C-O>',
      \   after_send: 'wipeout'
      \ },
      \ fish: #{
      \   key: '<C-O>',
      \   after_send: 'wipeout'
      \ },
      \ zsh: #{
      \   key: '<C-O>',
      \   after_send: 'wipeout'
      \ },
      \ jshell: #{
      \   key: '<C-O>'
      \ },
      \ python3: #{
      \   key: '<C-O>'
      \ },
      \ sqlite3: #{
      \   key: '<C-O>'
      \ },
      \ aider: #{
      \   key: '<C-J>',
      \   send_empty: 'crlf',
      \ },
      \ claude: #{
      \   key: '<C-J>',
      \   send_empty: 'crlf',
      \ }
      \}
```
