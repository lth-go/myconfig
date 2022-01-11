local fn = vim.fn

local present, wilder = pcall(require, "wilder")

if not present then
  return
end

wilder.setup({ modes = { ":", "/", "?" } })

wilder.set_option("pipeline", {
  wilder.branch(
    -- TODO: 仅cmd模式
    function(_, x)
      return string.len(x) <= 2 and "" or false
    end,
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

local hl_wilder_accent = wilder.make_hl("WilderAccent", "Keyword")
local scale = {
  "#f4468f",
  "#fd4a85",
  "#ff507a",
  "#ff566f",
  "#ff5e63",
  "#ff6658",
  "#ff704e",
  "#ff7a45",
  "#ff843d",
  "#ff9036",
  "#f89b31",
  "#efa72f",
  "#e6b32e",
  "#dcbe30",
  "#d2c934",
  "#c8d43a",
  "#bfde43",
  "#b6e84e",
  "#aff05b",
}
local gradient = {}

for i, v in ipairs(scale) do
  table.insert(gradient, wilder.make_hl("Accent" .. i, "Keyword", { { foo = "" }, { foo = "" }, { foreground = v } }))
end

local wilder_popupmenu_renderer = wilder.popupmenu_renderer({
  highlights = {
    -- accent = hl_wilder_accent,
    gradient = gradient,
  },
  highlighter = {
    wilder.highlighter_with_gradient({
      wilder.basic_highlighter(),
    }),
  },
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
