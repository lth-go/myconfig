---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    diagnostics = {
      virtual_text = false,
      update_in_insert = false,
    },
    filetypes = {
      pattern = {
        ["dockerfile_.*"] = "dockerfile",
        ["Dockerfile_.*"] = "dockerfile",
        [".*/.kube/config"] = "yaml",
      },
    },
    options = {
      opt = {
        clipboard = vim.list_extend(vim.opt.clipboard:get(), { "unnamedplus" }),
        completeopt = { "menu", "menuone", "noselect" },
        cursorline = true,
        diffopt = vim.list_extend(vim.opt.diffopt:get(), { "algorithm:histogram", "linematch:60" }),
        expandtab = true,
        foldcolumn = "0",
        foldenable = false,
        ignorecase = true,
        jumpoptions = "view",
        laststatus = 3,
        list = true,
        listchars = "tab:--→,trail:-,nbsp:+",
        mouse = "",
        number = true,
        numberwidth = 2,
        readonly = vim.opt.diff:get() and false or vim.opt.readonly:get(),
        relativenumber = true,
        scrolloff = 10,
        shiftround = true,
        shiftwidth = 4,
        shortmess = vim.tbl_deep_extend("force", vim.opt.shortmess:get(), { c = true, s = true, I = true, W = true }),
        showmode = false,
        sidescrolloff = 10,
        signcolumn = "number",
        smartcase = true,
        smartindent = true,
        smoothscroll = true,
        softtabstop = 4,
        splitbelow = true,
        splitright = true,
        swapfile = false,
        tabstop = 4,
        termguicolors = true,
        timeoutlen = 1000,
        title = false,
        undofile = false,
        updatetime = 300,
        wildcharm = vim.opt.wildchar:get(),
        wildmode = "longest:full,full",
        wrap = false,
        writebackup = false,
      },
    },
    mappings = {
      [""] = {
        ["\\"] = { ";" },
        ["H"] = { "^" },
        ["L"] = { "g_" },
      },
      n = {
        ["\\"] = false,
        ["|"] = false,
        ["<Leader>g"] = false,
        ["<Leader>gC"] = false,
        ["<Leader>gb"] = false,
        ["<Leader>gc"] = false,
        ["<Leader>gg"] = false,
        ["<Leader>gt"] = false,
        ["<Leader>tf"] = false,
        ["<Leader>th"] = false,
        ["<Leader>tl"] = false,
        ["<Leader>tn"] = false,
        ["<Leader>tp"] = false,
        ["<Leader>tt"] = false,
        ["<Leader>tv"] = false,

        ["Q"] = { "<Nop>" },
        ["?"] = "/",
        ["<Leader>q"] = { "<Cmd>q<CR>" },
        ["<Leader>w"] = { "<Cmd>w<CR>" },
        ["<Leader>z"] = { "<Cmd>qa!<CR>" },
        ["<C-J>"] = { "<C-W><C-J>" },
        ["<C-K>"] = { "<C-W><C-K>" },
        ["<C-H>"] = { "<C-W><C-H>" },
        ["<C-L>"] = { "<C-W><C-L>" },
        ["j"] = { "v:count == 0 ? 'gj' : 'j'", expr = true, silent = true },
        ["k"] = { "v:count == 0 ? 'gk' : 'k'", expr = true, silent = true },
        ["n"] = { "nzz" },
        ["N"] = { "Nzz" },
        ["<C-O>"] = { "<C-O>zz" },
        ["<C-I>"] = { "<C-I>zz" },
        ["<C-]>"] = { "<C-]>zz" },
        ["<Backspace>"] = { "<Cmd>nohlsearch<CR>" },
        ["<Esc>"] = { "<Cmd>nohlsearch<CR><Esc>" },
        ["<Leader>y"] = { [[""y]] },
        ["<Leader>d"] = { [[""d]] },
        ["<Leader>p"] = { [[""p]] },
        ["<Leader>P"] = { [[""P]] },
        ["<Leader><Space>"] = { "<Cmd>vs<CR>" },
        ["<C-ScrollWheelUp>"] = { "4zh" },
        ["<C-ScrollWheelDown>"] = { "4zl" },

        ["<Leader>rn"] = {
          function()
            vim.lsp.buf.rename()
          end,
        },
        ["<C-G>"] = {
          function()
            local msg = string.format("%s:%s", vim.fn.expand("%"), vim.fn.line("."))
            vim.fn.setreg("+", msg)
            print(msg)
          end,
        },
        ["<A-g>"] = {
          function()
            local msg = string.format("%s/", vim.fn.expand("%:h"))
            vim.fn.setreg("+", msg)
            print(msg)
          end,
        },
      },
      i = {
        ["<C-B>"] = { "<Left>" },
        ["<C-F>"] = { "<Right>" },
        ["<C-A>"] = { "<Home>" },
        ["<C-E>"] = { "<End>" },
        ["<C-D>"] = { "<Del>" },
      },
      v = {
        ["<"] = "<gv",
        [">"] = ">gv",
      },
      x = {
        ["p"] = { [['pgv"' . v:register . 'y']], expr = true },
        ["i<space>"] = { [[:<c-u>normal! viW<CR>]], silent = true },
        ["a<space>"] = { [[:<c-u>normal! viW<CR>]], silent = true },
      },
      o = {
        ["i<space>"] = { [[:normal viW<CR>]], silent = true },
        ["a<space>"] = { [[:normal viW<CR>]], silent = true },
      },
      c = {
        ["<C-P>"] = { "<Up>" },
        ["<C-N>"] = { "<Down>" },
        ["<C-B>"] = { "<Left>" },
        ["<C-F>"] = { "<Right>" },
        ["<C-A>"] = { "<Home>" },
        ["<C-E>"] = { "<End>" },
        ["<C-D>"] = { "<Del>" },

        ["/"] = {
          function()
            local key = vim.api.nvim_replace_termcodes("<Down>", true, true, true)
            return vim.fn.pumvisible() == 1 and key or "/"
          end,
        },
      },
      t = {
        ["<C-X>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true) },
      },
    },
    autocmds = {
      highlightyank = false,
      custom = {
        {
          event = "CursorHold",
          callback = function()
            vim.diagnostic.open_float({ scope = "cursor", focus = false })
          end,
        },
        {
          event = { "BufEnter", "FocusGained", "InsertLeave", "WinEnter" },
          desc = "auto relativenumber on",
          pattern = "*",
          callback = function()
            if vim.opt_local.number:get() then
              vim.opt_local.relativenumber = true
            end
          end,
        },
        {
          event = { "BufLeave", "FocusLost", "InsertEnter", "WinLeave" },
          desc = "auto relativenumber off",
          pattern = "*",
          callback = function()
            if vim.opt_local.number:get() then
              vim.opt_local.relativenumber = false
            end
          end,
        },
        {
          event = "StdinReadPost",
          pattern = "*",
          callback = function()
            vim.opt.modified = false
            vim.opt.mouse = "a"
          end,
        },
        {
          event = "BufReadPost",
          callback = function(args)
            if not vim.api.nvim_buf_is_valid(args.buf) then
              return
            end

            if vim.api.nvim_get_option_value("buftype", { buf = args.buf }) ~= "" then
              return
            end

            local current_file = vim.api.nvim_buf_get_name(args.buf)
            if current_file == "" then
              return
            end

            require("pkg.utils.mru").add(current_file)
          end,
        },
      },
    },
    on_keys = {
      auto_hlsearch = false,
    },
  },
}
