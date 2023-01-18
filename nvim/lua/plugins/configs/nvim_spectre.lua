local present, leap = pcall(require, "spectre")

if not present then
  return
end

require("spectre").setup({
  live_update = true,
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
