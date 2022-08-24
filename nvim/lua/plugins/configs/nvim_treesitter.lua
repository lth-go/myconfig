local present, treesitter = pcall(require, "nvim-treesitter.configs")

if not present then
  return
end

treesitter.setup({
  ensure_installed = "all",
  highlight = {
    enable = true,
    disable = function(lang, bufnr)
      -- 渲染有问题
      if lang == "dockerfile" then
        return true
      end

      return vim.api.nvim_buf_line_count(bufnr) > 8192
    end,
    use_languagetree = true,
  },
  indent = {
    enable = false,
    use_languagetree = true,
  },
})
