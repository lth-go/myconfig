setlocal noexpandtab
setlocal tabstop=4
setlocal shiftwidth=4

nnoremap <buffer> <silent> ]] :<c-u>call custom#go#textobj#FunctionJump('n', 'next')<cr>
nnoremap <buffer> <silent> [[ :<c-u>call custom#go#textobj#FunctionJump('n', 'prev')<cr>
