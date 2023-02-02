local present, treesitter = pcall(require, "nvim-treesitter.configs")

if not present then
  return
end

local vim = vim

treesitter.setup({
  ensure_installed = "all",
  highlight = {
    enable = true,
    disable = function(lang, bufnr)
      -- 渲染有问题
      if lang == "dockerfile" then
        return true
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
    use_languagetree = true,
  },
  indent = {
    enable = false,
  },
})
