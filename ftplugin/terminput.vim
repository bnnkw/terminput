vim9script

import autoload 'terminput.vim'

b:terminput_term_bufnr = bufnr('#')

setlocal buftype=nofile
setlocal winfixheight
resize 5

const after_send_actions: dict<func(): void> = {
  clear: () => {
    deletebufline(bufnr(), 1, '$')
  },
  wipeout: () => {
    execute('bwipeout')
  },
}

def SendToTerm(): void
  var lines = getbufline(bufnr(), 1, '$')

  if lines == [''] && g:terminput_send_empty == 'crlf'
    terminput.Send(b:terminput_term_bufnr, "\<CR>")
    if !has_key(after_send_actions, g:terminput_after_send)
      echoerr $'terminput: invalid g:terminput_after_send: "{g:terminput_after_send}". Valid: {keys(after_send_actions)->join(", ")}'
      return
    endif
    after_send_actions[g:terminput_after_send]()
    return
  endif

  var content = lines->join("\n")
  setreg('t', content)
  content = lines
    ->map((_, l) => substitute(l, "\t", ' ', 'g'))
    ->join("\n")
  terminput.Send(b:terminput_term_bufnr, content)
  if !has_key(after_send_actions, g:terminput_after_send)
    echoerr $'terminput: invalid g:terminput_after_send: "{g:terminput_after_send}". Valid: {keys(after_send_actions)->join(", ")}'
    return
  endif
  after_send_actions[g:terminput_after_send]()
enddef

nnoremap <buffer> <CR> <ScriptCmd>call SendToTerm()<CR>
