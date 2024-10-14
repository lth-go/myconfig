return {
  "numToStr/Comment.nvim",
  specs = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings

        maps.n["<C-_>"] = {
          function()
            local motion = (vim.v.count == 0 and "current" or "count_repeat")
            return require("Comment.api").call("toggle.linewise." .. motion, "g@$")()
          end,
          expr = true,
          silent = true,
          desc = "Toggle comment line",
        }
        maps.x["<C-_>"] = {
          "<Esc><Cmd>lua require('Comment.api').locked('toggle.linewise')(vim.fn.visualmode())<CR>",
          desc = "Toggle comment",
        }

        return opts
      end,
    },
  },
  opts = {
    ignore = "^$",
  },
}
