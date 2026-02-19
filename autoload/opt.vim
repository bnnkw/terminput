vim9script

export enum SendEmpty
  none(""),
  space("\<Space>"),
  tab("\<Tab>"),
  lf("\<NL>"),
  crlf("\<CR>")

  var keycode: string

  static def FromString(s: string): SendEmpty
    var matches = SendEmpty.values
      ->copy()
      ->filter((_, v) => v.name ==# s)
    if empty(matches)
      var valid = SendEmpty.values
        ->copy()
        ->map((_, v) => v.name)
        ->join(", ")
      throw $'terminput: invalid g:terminput_send_empty: "{s}". Valid: {valid}'
    endif
    return matches[0]
  enddef
endenum

export def Parse(conf: dict<any>, default: dict<any>): dict<any>
  var avail = ['key', 'send_empty', 'after_send']

  var parsed: dict<any> = {}
  for comm in keys(conf)
    for k in keys(conf[comm])
      if index(avail, k) == -1
        throw $"terminput: the key '{k}' is not available in the config '{comm}'"
      endif
    endfor
    parsed[comm] = extend(copy(conf[comm]), default, 'keep')
  endfor

  return parsed
enddef
