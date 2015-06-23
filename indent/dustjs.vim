" indent/dustjs.vim
if exists("b:did_indent")
  finish
endif
let b:did_indent = 1
runtime! indent/html.vim
setlocal indentexpr = &indentexpr
