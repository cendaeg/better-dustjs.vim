" indent/dustjs.vim
if exists("b:did_indent")
  finish
endif
let s:doing_indent_inits = 1
runtime! indent/html.vim
unlet b:did_indent
unlet s:doing_indent_inits


setlocal indentexpr=DustJSIndent()

function! DustJSIndent()
  if exists('*HtmlIndent')
    let html_ind = HtmlIndent()
  else
    let html_ind = HtmlIndentGet(a:lnum)
  endif
  let line = getline(v:lnum)
  let previousNum = prevnonblank(v:lnum - 1)
  let previous = getline(previousNum)
  echo previous
  if previous =~ "{" && previous !~ "}" && line !~ "}" && line !~ ":$"
    return indent(previousNum) + &tabstop
  endif

  ...
endfunction
