local fn = vim.fn

fn['wilder#setup']({ modes = { ':', '/', '?' }, enable_cmdline_enter = 0 })

vim.cmd([[
call wilder#set_option('pipeline', [
  \ wilder#branch(
  \   wilder#substitute_pipeline({
  \     'pipeline': wilder#python_search_pipeline({
  \       'skip_cmdtype_check': 1,
  \       'pattern': wilder#python_fuzzy_pattern({
  \         'start_at_boundary': 0,
  \       }),
  \     }),
  \   }),
  \   wilder#cmdline_pipeline({
  \     'fuzzy': 1,
  \     'set_pcre2_pattern': 1,
  \     'sorter': wilder#python_difflib_sorter(),
  \   }),
  \   wilder#python_search_pipeline({
  \     'pattern': wilder#python_fuzzy_pattern({
  \       'start_at_boundary': 0,
  \     }),
  \   }),
  \ ),
\ ])

let g:wilder_popupmenu_renderer = wilder#popupmenu_renderer({
  \ 'highlights': {
  \    'accent': wilder#make_hl('WilderAccent', 'Pmenu', [{}, {}, {'foreground': '#f4468f'}]),
  \ },
  \ 'highlighter': [wilder#pcre2_highlighter()],
  \ 'left': [
  \   ' ',
  \   wilder#popupmenu_devicons(),
  \ ],
  \ 'right': [
  \   ' ',
  \   wilder#popupmenu_scrollbar(),
  \ ],
\ })

let g:wilder_wildmenu_renderer = wilder#wildmenu_renderer({
  \ 'highlights': {
  \    'accent': wilder#make_hl('WilderAccent', 'Pmenu', [{}, {}, {'foreground': '#f4468f'}]),
  \  },
  \ 'highlighter': [wilder#pcre2_highlighter()],
  \ 'apply_incsearch_fix': 1,
\ })

call wilder#set_option('renderer', wilder#renderer_mux({
  \ ':': g:wilder_popupmenu_renderer,
  \ '/': g:wilder_wildmenu_renderer,
  \ 'substitute': g:wilder_wildmenu_renderer,
\ }))
]])
