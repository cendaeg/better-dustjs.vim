" indent/dustjs.vim
if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

let s:cpo_save = &cpo
set cpo&vim

setlocal indentexpr=DustIndent(v:lnum)

function! DustIndent(lnum)
  let line = getline(a:lnum)
  let previousNum = prevnonblank(a:lnum - 1)
  let previous = getline(previousNum)
  let cindent = cindent(a:lnum)
  let previousIndent = indent(previousNum)
  echo line
