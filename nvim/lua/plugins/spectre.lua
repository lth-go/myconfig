return {
  "windwp/nvim-spectre",
  keys = { "<Leader>sr" },
  config = function()
    local spectre = require("spectre")

    spectre.setup({
      highlight = {
        ui = "String",
        search = "SpectreSearch",
        replace = "SpectreReplace",
      },
      mapping = {
        ["send_to_qf"] = {
          map = "<C-q>",
          cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
          desc = "send all item to quickfix",
        },
      },
    })

    vim.keymap.set("n", "<Leader>sr", spectre.open, { noremap = true })
  end,
}
