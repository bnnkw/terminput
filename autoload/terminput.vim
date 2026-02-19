vim9script

export def OpenTermInputBuffer(winid: number, conf: dict<any>): void
  if getwinvar(winid, '&buftype') != 'terminal'
    echoerr $'terminput: the window {winid} is not a terminal window.'
    return
  endif
  belowright new
  autocmd_add([{
    group: 'terminput_open',
    event: 'WinClosed',
    pattern: $'{winid}',
    cmd:  $'if bufexists({bufnr()}) | bwipeout {bufnr()} | endif',
    once: true,
  }])
  set filetype=terminput
  b:terminput_config = conf
enddef

def ProcStat(pid: number): dict<any>
  var p = $'/proc/{pid}/stat'
  if !filereadable(p)
    return {}
  endif

  var line = readfile(p)[0]
  var start = stridx(line, '(')
  if start == -1
    return {}
  endif
  start = start + 1
  var end = strridx(line, ')')
  if end == -1
    return {}
  endif

  var comm = strpart(line, start, end - start)
  # skip ') '
  var fields = [pid] + [comm] + strpart(line, end + 2)->split()

  return {pid: fields[0], comm: fields[1], tpgid: str2nr(fields[7])}
enddef

export def GetForeground(bufnr: number): string
  var job = term_getjob(bufnr)
  if job == null_job
    return ''
  endif

  var info = job_info(job)
  var shell_pid = info.process
  var stat = ProcStat(shell_pid)
  if empty(stat)
    return ''
  endif

  var tpgid = stat.tpgid
  if tpgid == shell_pid
    return stat.comm
  endif

  var fg_comm_path = $'/proc/{tpgid}/comm'
  if !filereadable(fg_comm_path)
    return ''
  endif
  return trim(readfile(fg_comm_path)[0])
enddef

export def Send(term: number, content: string)
  term_sendkeys(term, content)
enddef
