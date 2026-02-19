set nocompatible

execute $'set runtimepath+={getcwd()}'
filetype plugin on

let g:terminput_mappings = #{
      \ bash: #{
      \   key: '<C-O>'
      \ },
      \ claude: #{
      \   key: '<C-J>',
      \   send_empty: 'crlf',
      \ },
      \ sqlite: #{
      \   key: '<C-S>',
      \   send_empty: 'lf',
      \   after_send: 'wipeout'
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
