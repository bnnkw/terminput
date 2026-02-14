set nocompatible

execute $'set runtimepath+={getcwd()}'
filetype plugin on

let g:terminput_mappings = #{
      \ bash: '<C-O>'
      \}

call term_start([
      \ '/bin/bash',
      \ '--noprofile',
      \ '--norc'
      \ ], #{
      \   curwin: v:true,
      \   term_name: 'demo'
      \ }
      \)
