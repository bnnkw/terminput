vim9script

import autoload 'terminput.vim'
import autoload 'opt.vim'

b:terminput_term_bufnr = bufnr('#')

setlocal buftype=nofile
setlocal winfixheight
setlocal nobuflisted
resize 5

const after_send_actions: dict<func(): void> = {
  clear: () => {
    deletebufline(bufnr(), 1, '$')
  },
  wipeout: () => {
    execute('bwipeout')
  },
}

def AfterSendAction()
  if !has_key(after_send_actions, b:terminput_config.after_send)
    echoerr $'terminput: invalid g:terminput_after_send: "{b:terminput_config.after_send}". Valid: {keys(after_send_actions)->join(", ")}'
    return
  endif
  after_send_actions[b:terminput_config.after_send]()
enddef

def SendToTerm(): void
  var lines = getbufline(bufnr(), 1, '$')
  if lines == ['']
    var se: opt.SendEmpty
    try
      se = opt.SendEmpty.FromString(b:terminput_config.send_empty)
    catch
      echoerr v:exception
      return
    endtry
    if se == opt.SendEmpty.none
      return
    endif
    terminput.Send(b:terminput_term_bufnr, se.keycode)
  else
    var content = lines->join("\n")
    setreg('t', content)
    content = lines
      ->map((_, l) => substitute(l, "\t", ' ', 'g'))
      ->join("\n")
    terminput.Send(b:terminput_term_bufnr, content)
  endif
  AfterSendAction()
enddef

nnoremap <buffer> <CR> <ScriptCmd>call SendToTerm()<CR>
