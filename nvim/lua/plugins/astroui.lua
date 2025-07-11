---@type LazySpec
return {
  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = {
      colorscheme = "gruvbox-material",
      highlights = {
        init = {
          ["@string.special.url"] = { link = "Normal" },
        },
      },
    },
  },

  {
    "sainnhe/gruvbox-material",
    dependencies = {
      "AstroNvim/astroui",
      opts = function()
        vim.g.gruvbox_material_background = "hard"
        vim.g.gruvbox_material_foreground = "original"
        vim.g.gruvbox_material_better_performance = 0
        vim.g.gruvbox_material_disable_italic_comment = 1
        vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
      end,
    },
  },
}
