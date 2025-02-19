local file_types = {
  "bash",
  "go",
  "gomod",
  "json",
  "lua",
  "make",
  "proto",
  "python",
  "rust",
  "sh",
  "sql",
  "toml",
  "yaml",
}

local hijack = function()
  local binary = require("supermaven-nvim.binary.binary_handler")
  local old_on_update = binary.on_update

  binary.on_update = function(self, buffer, file_name, event_type)
    if not vim.tbl_contains(file_types, vim.bo.filetype) then
      return
    end

    old_on_update(self, buffer, file_name, event_type)
  end
end

return {
  "supermaven-inc/supermaven-nvim",
  ft = file_types,
  config = function()
    hijack()

    require("supermaven-nvim").setup({
      keymaps = {
        accept_suggestion = "<C-j>",
        clear_suggestion = "<C-]>",
        accept_word = "<A-j>",
      },
      ignore_filetypes = {},
      color = {
        suggestion_color = "#928374",
        cterm = 245,
      },
      log_level = "error",
      disable_inline_completion = false,
      disable_keymaps = false,
    })
  end,
}
