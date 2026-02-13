set nocompatible

execute $'set runtimepath+={getcwd()}'
filetype plugin on

let g:terminput_mappings = #{
      \ bash: '<C-O>'
      \}

terminal ++curwin
