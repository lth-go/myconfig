local fn = vim.fn

local present, wilder = pcall(require, "wilder")

if not present then
  return
end

wilder.setup({ modes = { ":", "/", "?" } })

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
    {
      function(ctx, x)
        if string.len(x) <= 2 then
          return false
        end

        return x
      end,
      table.unpack(wilder.cmdline_pipeline({
        fuzzy = 1,
        set_pcre2_pattern = 1,
        sorter = wilder.python_difflib_sorter(),
      })),
    },
    wilder.python_search_pipeline({
      pattern = wilder.python_fuzzy_pattern({
        start_at_boundary = 0,
      }),
    })
  ),
})

local scale = { '#e1524a','#ec6449','#f3784c','#f88e53','#fba35e' }
local gradient = {}

for i, v in ipairs(scale) do
  table.insert(gradient, wilder.make_hl("WilderGradient" .. i, "Pmenu", { {}, {}, { v } }))
end

local wilder_popupmenu_renderer = wilder.popupmenu_renderer({
  highlights = {
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
    gradient = gradient,
  },
  highlighter = {
    wilder.highlighter_with_gradient({
      wilder.basic_highlighter(),
    }),
  },
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
