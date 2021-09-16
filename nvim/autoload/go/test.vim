" don't spam the user when Vim is started in Vi compatibility mode
let s:cpo_save = &cpo
set cpo&vim

" Testfunc runs a single test that surrounds the current cursor position.
" Arguments are passed to the `go test` command.
function! go#test#Func(bang, ...) abort
  let l:test = go#util#TestName()
  if l:test is ''
    call go#util#EchoWarning("[test] no test found immediate to cursor")
    return
  endif

  execute "FloatermNew --name=go-test go test -v -count=1 -run '" . "^" . l:test . "$' ./" . expand('%:h')
endfunction

" restore Vi compatibility settings
let &cpo = s:cpo_save
unlet s:cpo_save

" vim: sw=2 ts=2 et
