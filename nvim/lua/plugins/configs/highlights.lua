local vim = vim
local cmd = vim.cmd
local nvim_set_hl = vim.api.nvim_set_hl

cmd.colorscheme("gruvbox-material")

nvim_set_hl(0, "CocExplorerFileDirectoryExpanded", { fg = "#8094b4" })
nvim_set_hl(0, "CocExplorerFileDirectoryCollapsed", { fg = "#8094b4" })

nvim_set_hl(0, "StartLogo1", { fg = "#1C506B" })
nvim_set_hl(0, "StartLogo2", { fg = "#1D5D68" })
nvim_set_hl(0, "StartLogo3", { fg = "#1E6965" })
nvim_set_hl(0, "StartLogo4", { fg = "#1F7562" })
nvim_set_hl(0, "StartLogo5", { fg = "#21825F" })
nvim_set_hl(0, "StartLogo6", { fg = "#228E5C" })
nvim_set_hl(0, "StartLogo7", { fg = "#239B59" })
nvim_set_hl(0, "StartLogo8", { fg = "#24A755" })

nvim_set_hl(0, "SpectreSearch", { reverse = true, ctermfg = 107, ctermbg = 234, fg = "#8ec07c", bg = "#1d2021" })
nvim_set_hl(0, "SpectreReplace", { reverse = true, ctermfg = 203, ctermbg = 234, fg = "#fb4934", bg = "#1d2021" })
