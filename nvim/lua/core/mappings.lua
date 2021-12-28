local utils = require "core.utils"

local map = utils.map

local M = {}

M.misc = function()
  map("n", "<Leader>bd", ":lua require('core.utils').buf_only()<CR>", { noremap = true, silent = true })
end

return M
