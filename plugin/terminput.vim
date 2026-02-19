vim9script

import autoload 'terminput.vim'
import autoload 'opt.vim'

command! TermInputOpen OpenTermInput(terminput.GetForeground(bufnr()))
command! TermInputConfigUpdate UpdateConfig()
command! TermInputConfigShow echo config

var config = {}
var key_bytes: dict<string> = {}

def OpenTermInput(comm: string)
  terminput.OpenTermInputBuffer(win_getid(), config[comm])
enddef

def TermInputAction(key: string)
  var fg = terminput.GetForeground(bufnr())
  if has_key(config, fg) && key == get(config[fg], 'key')
    OpenTermInput(fg)
  else
    terminput.Send(bufnr(), key_bytes[key])
  endif
enddef

def SetupTermInputMappings()
  for comm in keys(config)
    var mapped_key = config[comm]['key']
    key_bytes[mapped_key] = eval($'"\{mapped_key}"')
    # the first '<' to '<lt>'
    var escaped = keytrans(mapped_key)
    execute $'tnoremap {mapped_key} <Cmd>call <SID>TermInputAction("{escaped}")<CR>'
  endfor
enddef

def DefaultConfig(): dict<any>
  return {
    key: '',
    after_send: get(g:, 'terminput_after_send', 'clear'),
    send_empty: get(g:, 'terminput_send_empty', 'crlf'),
  }
enddef

def UpdateConfig()
  if !exists('g:terminput_config')
    config = {}
    return
  endif
  config = opt.Parse(g:terminput_config, DefaultConfig())
  SetupTermInputMappings()
enddef

UpdateConfig()
