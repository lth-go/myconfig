return {
  "gelguy/wilder.nvim",
  build = ":UpdateRemotePlugins",
  config = function()
    local wilder = require("wilder")

    wilder.setup({
      modes = { ":" },
    })

    wilder.set_option({
      pipeline = {
        wilder.branch(
          wilder.check(function(_, x)
            return x == ""
          end),
          wilder.cmdline_pipeline({
            fuzzy = 1,
            sorter = wilder.python_difflib_sorter(),
          })
        ),
      },
      renderer = wilder.renderer_mux({
        [":"] = wilder.popupmenu_renderer({
          highlights = {
            accent = wilder.make_hl("WilderAccent", "Pmenu", { {}, {}, { "#f4468f" } }),
          },
          highlighter = {
            wilder.highlighter_with_gradient({
              wilder.basic_highlighter(),
            }),
          },
          left = { " ", wilder.popupmenu_devicons() },
          right = { " ", wilder.popupmenu_scrollbar() },
        }),
      }),
    })

    vim.keymap.set("c", "/", [[wilder#can_accept_completion() ? wilder#accept_completion(0) : "/"]], { expr = true, replace_keycodes = false })
  end,
}
