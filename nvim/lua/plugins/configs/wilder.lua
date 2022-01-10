local fn = vim.fn

local present, wilder = pcall(require, "wilder")

if not present then
  return
end

wilder.setup({ modes = { ":", "/", "?" }, enable_cmdline_enter = 1 })

wilder.set_option("pipeline", {
  wilder.branch(
    wilder.substitute_pipeline({
      pipeline = wilder.python_search_pipeline({
        skip_cmdtype_check = 1,
        pattern = wilder.python_fuzzy_pattern({
          start_at_boundary = 0,
        }),
      }),
    }),
    wilder.cmdline_pipeline({
      fuzzy = 1,
      set_pcre2_pattern = 1,
      sorter = wilder.python_difflib_sorter(),
    }),
    wilder.python_search_pipeline({
      pattern = wilder.python_fuzzy_pattern({
        start_at_boundary = 0,
      }),
    })
  ),
})

local hl_wilder_accent = wilder.make_hl("WilderAccent", "Search")

local wilder_popupmenu_renderer = wilder.popupmenu_renderer({
  highlights = {
    accent = hl_wilder_accent,
  },
  highlighter = { wilder.pcre2_highlighter() },
  left = { " ", wilder.popupmenu_devicons() },
  right = { " ", wilder.popupmenu_scrollbar() },
})

local wilder_wildmenu_renderer = wilder.wildmenu_renderer({
  highlights = {
    accent = hl_wilder_accent,
  },
  highlighter = { wilder.pcre2_highlighter() },
  apply_incsearch_fix = 1,
})

wilder.set_option(
  "renderer",
  wilder.renderer_mux({
    [":"] = wilder_popupmenu_renderer,
    ["/"] = wilder_wildmenu_renderer,
    ["substitute"] = wilder_wildmenu_renderer,
  })
)
