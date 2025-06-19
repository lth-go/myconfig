return {
  "ggandor/leap.nvim",
  config = function()
    local leap = require("leap")

    leap.setup({
      safe_labels = {},
      on_beacons = function(_, start, _)
        return start ~= nil
      end,
    })

    vim.keymap.set({ "n" }, "s", "<Plug>(leap-forward)")
    vim.keymap.set({ "n" }, "S", "<Plug>(leap-backward)")
  end,
}
