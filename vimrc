set nocompatible

execute $'set runtimepath+={getcwd()}'
filetype plugin on

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

call term_start([
      \ '/bin/bash',
      \ '--noprofile',
      \ '--norc'
      \ ], #{
      \   curwin: v:true,
      \   term_finish: 'close',
      \   term_name: 'demo'
      \ }
      \)
