local opt = vim.opt
local g = vim.g

opt.termguicolors = true

opt.updatetime = 300
opt.shortmess:append("csI")
opt.jumpoptions:append("stack")
opt.inccommand = "nosplit"
opt.completeopt:remove("preview")

opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.hidden = true

opt.wildmode = "longest:full,full"
opt.wildcharm = opt.wildchar:get()

opt.wildignore:append(".vim,.idea,.git")
opt.wildignore:append("*.swp,tags")
opt.wildignore:append("*.o,*.a,*.so")
opt.wildignore:append("*.pyc,*.pyo")
opt.wildignore:append("*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz")

opt.number = true
opt.relativenumber = true

opt.foldenable = false
opt.wrap = false
opt.cursorline = true
opt.list = true
opt.listchars = "tab:>-,trail:·,nbsp:·"
opt.signcolumn = "number"

opt.pumblend = 10
opt.winblend = 10

opt.scrolloff = 10
opt.sidescrolloff = 10

opt.splitbelow = true
opt.splitright = true

opt.ignorecase = true
opt.smartcase = true

opt.cindent = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.shiftround = true

opt.clipboard:append("unnamedplus")

if opt.diff:get() then
  opt.readonly = false
end
