return {
  "windwp/nvim-spectre",
  keys = {
    {
      "<Leader>sr",
      function()
        require("spectre").open()
      end,
    },
  },
  config = function()
    local spectre = require("spectre")

    spectre.setup({
      highlight = {
        search = "DiffDelete",
        replace = "DiffChange",
      },
      mapping = {
        ["send_to_qf"] = {
          map = "<C-q>",
          cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
          desc = "send all item to quickfix",
        },
      },
    })
  end,
}
