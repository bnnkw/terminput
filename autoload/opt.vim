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
