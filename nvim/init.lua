local present, impatient = pcall(require, "impatient")

if present then
  impatient.enable_profile()
end

vim.defer_fn(function()
  local mappings = require("core.mappings")

  for _, section_mappings in pairs(mappings) do
    section_mappings()
  end
end, 0)

local core_modules = {
  "core.options",
  "core.autocmds",
}

for _, module in ipairs(core_modules) do
  local ok, err = pcall(require, module)
  if not ok then
    error("Error loading " .. module .. "\n\n" .. err)
  end
end
