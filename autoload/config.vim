vim9script

import autoload 'opt.vim'

var current: dict<any> = {}

export def Current(): dict<any>
  return deepcopy(current)
enddef

export def GetEntry(comm: string): dict<any>
  return copy(get(current, comm, {}))
enddef

export def MatchesField(comm: string, field: string, value: any): bool
  return has_key(current, comm) && get(current[comm], field) == value
enddef

export def Initialize()
  if !exists('g:terminput_config')
    current = {}
    return
  endif
  current = opt.Parse(g:terminput_config, DefaultConfig())
enddef

def DefaultConfig(): dict<any>
  return {
    key: '',
    after_send: get(g:, 'terminput_after_send', 'clear'),
    send_empty: get(g:, 'terminput_send_empty', 'crlf'),
  }
enddef
