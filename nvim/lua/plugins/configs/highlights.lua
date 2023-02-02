local vim = vim
local nvim_set_hl = vim.api.nvim_set_hl

local cmd = vim.cmd

cmd.colorscheme("gruvbox8_hard")

nvim_set_hl(0, "CocExplorerFileDirectoryExpanded", { fg = "#8094b4" })
nvim_set_hl(0, "CocExplorerFileDirectoryCollapsed", { fg = "#8094b4" })
nvim_set_hl(0, "QuickFixLine", { link = "CursorLine" })

nvim_set_hl(0, "StartLogo1", { fg = "#1C506B" })
nvim_set_hl(0, "StartLogo2", { fg = "#1D5D68" })
nvim_set_hl(0, "StartLogo3", { fg = "#1E6965" })
nvim_set_hl(0, "StartLogo4", { fg = "#1F7562" })
nvim_set_hl(0, "StartLogo5", { fg = "#21825F" })
nvim_set_hl(0, "StartLogo6", { fg = "#228E5C" })
nvim_set_hl(0, "StartLogo7", { fg = "#239B59" })
nvim_set_hl(0, "StartLogo8", { fg = "#24A755" })

nvim_set_hl(0, "DiffAdd", {})
nvim_set_hl(0, "DiffChange", {})
nvim_set_hl(0, "DiffDelete", {})
nvim_set_hl(0, "DiffText", {})
nvim_set_hl(0, "DiffAdd", { ctermfg = 234, ctermbg = 114, bg = "#26332c", fg = "NONE" })
nvim_set_hl(0, "DiffChange", { underline = true, ctermfg = 180, bg = "#273842", fg = "NONE" })
nvim_set_hl(0, "DiffDelete", { ctermfg = 234, ctermbg = 168, bg = "#572E33", fg = "#572E33" })
nvim_set_hl(0, "DiffText", { ctermfg = 234, ctermbg = 180, bg = "#314753", fg = "NONE" })

nvim_set_hl(0, "SpectreSearch", { reverse = true, ctermfg = 107, ctermbg = 234, fg = "#8ec07c", bg = "#1d2021" })
nvim_set_hl(0, "SpectreReplace", { reverse = true, ctermfg = 203, ctermbg = 234, fg = "#fb4934", bg = "#1d2021" })
