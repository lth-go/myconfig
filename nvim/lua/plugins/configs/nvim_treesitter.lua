local present, ts_config = pcall(require, "nvim-treesitter.configs")

if not present then
  return
end

ts_config.setup({
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    disable = function(lang, bufnr)
      return vim.api.nvim_buf_line_count(bufnr) > 8192
    end,
  },
  indent = {
    enable = false,
    use_languagetree = true,
  },
})
