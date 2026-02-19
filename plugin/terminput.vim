vim9script

import autoload 'terminput.vim'
import autoload 'config.vim'

command! TermInputOpen OpenTermInput(terminput.GetForeground(bufnr()))
command! TermInputConfigUpdate UpdateConfig()
command! TermInputConfigShow echo config.Current()

var key_bytes: dict<string> = {}

def OpenTermInput(comm: string)
  terminput.OpenTermInputBuffer(win_getid())
enddef

def TermInputAction(key: string)
  var fg = terminput.GetForeground(bufnr())
  if config.MatchesField(fg, 'key', key)
    OpenTermInput(fg)
  else
    terminput.Send(bufnr(), key_bytes[key])
  endif
enddef

def SetupTermInputMappings()
  var conf = config.Current()
  for comm in keys(conf)
    var mapped_key = conf[comm]['key']
    key_bytes[mapped_key] = eval($'"\{mapped_key}"')
    # the first '<' to '<lt>'
    var escaped = keytrans(mapped_key)
    execute $'tnoremap {mapped_key} <Cmd>call <SID>TermInputAction("{escaped}")<CR>'
  endfor
enddef

def UpdateConfig()
  config.Initialize()
  SetupTermInputMappings()
enddef

UpdateConfig()
