vim9script

import autoload 'terminput.vim'

if !exists('g:terminput_after_send')
  g:terminput_after_send = 'clear'
endif

command OpenTermInput {
  belowright new
  set filetype=terminput
}

var key_bytes: dict<string> = {}

def TermInputAction(key: string)
  var mappings: dict<string> = g:terminput_mappings
  var fg = terminput.GetForeground(bufnr())

  if (has_key(mappings, fg) && key == get(mappings, fg))
      || (has_key(mappings, '_') && key == get(mappings, '_'))
    execute 'OpenTermInput'
    return
  endif

  terminput.Send(bufnr(), key_bytes[key])
enddef

def SetupTermInputMappings()
  if !exists('g:terminput_mappings')
    return
  endif

  for mapped_key in values(g:terminput_mappings)
    key_bytes[mapped_key] = eval($'"\{mapped_key}"')
    # the first '<' to '<lt>'
    var escaped = keytrans(mapped_key)
    execute $'tnoremap {mapped_key} <Cmd>call <SID>TermInputAction("{escaped}")<CR>'
  endfor
enddef

SetupTermInputMappings()
