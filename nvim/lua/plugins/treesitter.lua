---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "bash",
      "c",
      "comment",
      "cpp",
      "css",
      "diff",
      "dockerfile",
      "go",
      "gomod",
      "gosum",
      "gowork",
      "html",
      "javascript",
      "jsdoc",
      "json",
      "jsonc",
      "lua",
      "luadoc",
      "luap",
      "luau",
      "make",
      "markdown",
      "markdown_inline",
      "proto",
      "python",
      "query",
      "rust",
      "sql",
      "toml",
      "tsx",
      "vim",
      "vimdoc",
      "yaml",
    },
    highlight = {
      enable = true,
      disable = function(lang, bufnr)
        for _, file_type in ipairs({
          "dockerfile",
          "gomod",
          "gosum",
          "query",
          "sql",
        }) do
          if lang == file_type then
            return true
          end
        end

        if vim.api.nvim_buf_line_count(bufnr) > 8192 then
          return true
        end

        local buf_name = vim.api.nvim_buf_get_name(bufnr)
        local file_size = vim.api.nvim_call_function("getfsize", { buf_name })
        if file_size > 256 * 1024 then
          return true
        end

        return false
      end,
    },
    incremental_selection = { enable = false },
  },
}
