" indent/dustjs.vim
if exists("b:did_indent")
  finish
endif
runtime! indent/html.vim
let s:htmlindent = &indentexpr
let b:did_indent = 1

let s:cpo_save = &cpo
set cpo&vim

setlocal indentexpr=DustIndent(v:lnum)
setlocal indentkeys=o,O,*<Return>,<>>,{,},!^F

function! DustIndent(lnum)
  let line = getline(a:lnum)
  let previousNum = prevnonblank(a:lnum - 1)
  let previous = getline(previousNum)
  let cindent = cindent(a:lnum)
  let previousIndent = indent(previousNum)
  let html = '<'
  let htmle = '</'

  echo html
  if   0 < searchpair(html, '', htmle, 'nWb')
        \ && 0 < searchpair(html, '', htmle, 'nW')
    " we're inside html
    if getline(searchpair(html, '', '</', 'nWb')) !~ '<script [^>]*type=["'']\?text\/\(html\|\(ng-\)\?template\)'
          \ && getline(lnum) !~ html && getline(line) !~ htmle
      if restore_ic == 0
        setlocal noic
      endif
      if s:htmlindent == ''
        return cindent(line)
      else
        execute 'let ind = ' . s:htmlindent
        return ind
      endif
    endif
    if line =~ htmle
      return indent(searchpair(html, '', htmle, 'nWb'))
    endif
  endif
:endfunction
