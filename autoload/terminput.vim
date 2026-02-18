vim9script

export def OpenTermInputBuffer(bufnr: number): void
  if getbufvar(bufnr, '&buftype') != 'terminal'
    echoerr $'terminput: the buffer {bufnr} is not a terminal buffer.'
    return
  endif
  belowright new
  set filetype=terminput
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
