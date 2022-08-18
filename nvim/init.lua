vim.defer_fn(function()
  pcall(require, "impatient")
end, 0)

require("core.options")
require("core.autocmds")
require("core.mappings").init()
require("core.packer").bootstrap()
require("plugins")
