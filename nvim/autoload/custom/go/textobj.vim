" don't spam the user when Vim is started in Vi compatibility mode
let s:cpo_save = &cpo
set cpo&vim

function! custom#go#textobj#FunctionJump(mode, direction) abort
  " get count of the motion. This should be done before all the normal
  " expressions below as those reset this value(because they have zero
  " count!). We abstract -1 because the index starts from 0 in motion.
  let l:cnt = v:count1 - 1

  " set context mark so we can jump back with  '' or ``
  normal! m'

  " select already previously selected visual content and continue from there.
  " If it's the first time starts with the visual mode. This is needed so
  " after selecting something in visual mode, every consecutive motion
  " continues.
  if a:mode == 'v'
    normal! gv
  endif

  if a:mode == 'n'
    keepjumps normal! 0
  endif

  let l:result = go#textobj#FunctionLocation(a:direction, l:cnt)
  if l:result is 0
    keepjumps normal! ``
    return
  endif

  " we reached the end and there are no functions. The usual [[ or ]] jumps to
  " the top or bottom, we'll do the same.
  if type(result) == 4 && has_key(result, 'err') && result.err == "no functions found"
    if a:direction == 'next'
      keepjumps normal! G
    else " 'prev'
      keepjumps normal! gg
    endif
    return
  endif

  let info = result.fn

  " if we select something ,select all function
  if a:mode == 'v' && a:direction == 'next'
    keepjumps call cursor(info.rbrace.line, 1)
    return
  endif

  if a:mode == 'v' && a:direction == 'prev'
    if has_key(info, 'doc') && go#config#TextobjIncludeFunctionDoc()
      keepjumps call cursor(info.doc.line, 1)
    else
      keepjumps call cursor(info.func.line, 1)
    endif
    return
  endif

  let offset = 1

  if has_key(info, 'sig') && type(info.sig) == 4
    if has_key(info.sig, 'name_pos') && type(info.sig.name_pos) == 4
      let offset = get(info.sig.name_pos, 'col', 1)
    endif
  endif

  keepjumps call cursor(info.func.line, offset)
endfunction

" restore Vi compatibility settings
let &cpo = s:cpo_save
unlet s:cpo_save

" vim: sw=2 ts=2 et
