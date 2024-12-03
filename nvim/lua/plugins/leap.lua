return {
  "ggandor/leap.nvim",
  config = function()
    local leap = require("leap")

    vim.keymap.set({ "n" }, "s", "<Plug>(leap-forward)")
    vim.keymap.set({ "n" }, "S", "<Plug>(leap-backward)")

    leap.setup({
      max_phase_one_targets = 0,
      safe_labels = {},
    })
  end,
}
