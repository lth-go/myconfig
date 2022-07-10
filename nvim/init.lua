require("core.options")
require("core.autocmds")

vim.defer_fn(function()
  local mappings = require("core.mappings")

  for _, section_mappings in pairs(mappings) do
    section_mappings()
  end
end, 0)

require("core.packer").bootstrap()
require("plugins")
