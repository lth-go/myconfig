local vim = vim
local opt = vim.opt
local g = vim.g

g.mapleader = ";"

opt.cindent = true
opt.clipboard:append("unnamedplus")
opt.completeopt:remove("preview")
opt.cursorline = true
opt.diffopt:append("linematch:60")
opt.expandtab = true
opt.foldenable = false
opt.ignorecase = true
opt.jumpoptions = "view"
opt.laststatus = 3
opt.list = true
opt.listchars = "tab:--→,trail:-,nbsp:+"
opt.mouse = ""
opt.number = true
opt.numberwidth = 2
opt.pumblend = 10
opt.relativenumber = true
opt.scrolloff = 10
opt.shiftround = true
opt.shiftwidth = 4
opt.shortmess:append("csIW")
opt.showmode = false
opt.sidescrolloff = 10
opt.signcolumn = "number"
opt.smartcase = true
opt.smartindent = true
opt.smoothscroll = true
opt.softtabstop = 4
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.tabstop = 4
opt.termguicolors = true
opt.updatetime = 250
opt.wildcharm = opt.wildchar:get()
opt.wildignore:append("*.o,*.a,*.so")
opt.wildignore:append("*.pyc,*.pyo")
opt.wildignore:append("*.swp,tags")
opt.wildignore:append("*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz")
opt.wildignore:append(".vim,.idea,.git")
opt.wildmode = "longest:full,full"
-- opt.winblend = 10
opt.wrap = false
opt.writebackup = false

if opt.diff:get() then
  opt.readonly = false
end
