return {
  url = "https://codeberg.org/andyg/leap.nvim",
  config = function()
    local leap = require("leap")

    leap.setup({
      safe_labels = {},
      on_beacons = function(_, start_idx, _)
        return start_idx ~= nil
      end,
    })

    vim.keymap.set({ "n" }, "s", "<Plug>(leap)")
  end,
}
