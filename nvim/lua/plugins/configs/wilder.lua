vim.cmd([[
call wilder#setup({'modes': [':', '/', '?']})

call wilder#set_option('pipeline', [
  \ wilder#branch(
  \   {ctx, x -> empty(x) ? '' : v:false},
  \   {ctx, x -> index(['e', 'v', 'vs'], x) >= 0 ? '' : v:false},
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

let s:highlighters = [
  \ wilder#pcre2_highlighter(),
\ ]

let s:popupmenu_renderer = wilder#popupmenu_renderer({
  \ 'highlights': {
  \    'accent': wilder#make_hl('WilderAccent', 'Pmenu', [{}, {}, {'foreground': '#f4468f'}]),
  \ },
  \ 'highlighter': s:highlighters,
  \ 'left': [
  \   ' ',
  \   wilder#popupmenu_devicons(),
  \ ],
  \ 'right': [
  \   ' ',
  \   wilder#popupmenu_scrollbar(),
  \ ],
\ })

let s:wildmenu_renderer = wilder#wildmenu_renderer({
  \ 'highlights': {
  \    'accent': wilder#make_hl('WilderAccent', 'Pmenu', [{}, {}, {'foreground': '#f4468f'}]),
  \  },
  \ 'highlighter': s:highlighters,
  \ 'apply_incsearch_fix': 1,
\ })

call wilder#set_option('renderer', wilder#renderer_mux({
  \ ':': s:popupmenu_renderer,
  \ '/': s:wildmenu_renderer,
  \ 'substitute': s:wildmenu_renderer,
\ }))
]])
