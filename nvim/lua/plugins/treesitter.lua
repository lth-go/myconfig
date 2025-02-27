---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    auto_install = true,
    highlight = {
      enable = true,
      disable = function(lang, bufnr)
        local file_types = {
          "dockerfile",
        }

        for _, file_type in ipairs(file_types) do
          if lang == file_type then
            return true
          end
        end

        if vim.api.nvim_buf_line_count(bufnr) > 8192 then
          return true
        end

        local buf_name = vim.api.nvim_buf_get_name(bufnr)
        local file_size = vim.api.nvim_call_function("getfsize", { buf_name })
        if file_size > 1024 * 256 then
          return true
        end

        return false
      end,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-s>",
        node_incremental = "<C-s>",
        scope_incremental = false,
        node_decremental = "<BS>",
      },
    },
    textobjects = {
      select = {
        enable = true,
        keymaps = {
          ["as"] = { query = "@statement.outer" },
          ["is"] = { query = "@statement.outer" },
        },
      },
      move = {
        goto_next_start = {
          ["]]"] = "@local.name",
        },
        goto_previous_start = {
          ["[["] = "@local.name",
        },
      },
    },
  },
}
