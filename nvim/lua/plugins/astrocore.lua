---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    diagnostics = {
      virtual_text = false,
    },
    options = {
      opt = {
        clipboard = vim.list_extend(vim.opt.clipboard:get(), { "unnamedplus" }),
        completeopt = { "menu", "menuone", "noselect" },
        cursorline = true,
        diffopt = vim.list_extend(vim.opt.diffopt:get(), { "algorithm:histogram", "linematch:60" }),
        expandtab = true,
        foldenable = false,
        ignorecase = true,
        jumpoptions = "stack",
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
        shiftwidth = 0,
        shortmess = vim.tbl_deep_extend("force", vim.opt.shortmess:get(), { c = true, C = true, s = true, I = true, W = true }),
        showmode = false,
        sidescrolloff = 10,
        signcolumn = "number",
        smartcase = true,
        smartindent = true,
        smoothscroll = true,
        splitbelow = true,
        splitright = true,
        swapfile = false,
        tabstop = 2,
        termguicolors = true,
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
        ["Q"] = { "<Nop>" },
        ["?"] = "/",
        ["n"] = { "nzz" },
        ["N"] = { "Nzz" },
        ["<C-O>"] = { "<C-O>zz" },
        ["<C-I>"] = { "<C-I>zz" },
        ["<Backspace>"] = { "<Cmd>nohlsearch<CR>" },
        ["<Esc>"] = { "<Cmd>nohlsearch<CR><Esc>" },
        ["<C-ScrollWheelUp>"] = { "4zh" },
        ["<C-ScrollWheelDown>"] = { "4zl" },
        ["<Leader>q"] = { "<Cmd>q<CR>" },
        ["<Leader>w"] = { "<Cmd>wa<CR>" },
        ["<Leader>z"] = { "<Cmd>qa!<CR>" },
        ["<Leader><Space>"] = { "<Cmd>vs<CR>" },
        ["<Leader>rn"] = {
          function()
            vim.lsp.buf.rename()
          end,
        },
        ["<C-G>"] = {
          function()
            local msg = string.format("%s:%s", vim.fn.expand("%:~:."), vim.fn.line("."))
            vim.fn.setreg("+", msg)
            print(msg)
          end,
        },
        ["<Leader>bd"] = {
          function()
            require("pkg.utils.bufdelete").buf_delete_other()
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
        ["K"] = { "<Nop>" },
        ["<"] = "<gv",
        [">"] = ">gv",
      },
      x = {
        ["p"] = { [['pgv"' . v:register . 'y']], expr = true },
        ["i<Space>"] = { [[:<c-u>normal! viW<CR>]], silent = true },
        ["a<Space>"] = { [[:<c-u>normal! viW<CR>]], silent = true },
      },
      o = {
        ["i<Space>"] = { [[:normal viW<CR>]], silent = true },
        ["a<Space>"] = { [[:normal viW<CR>]], silent = true },
      },
      c = {
        ["<C-P>"] = { "<Up>" },
        ["<C-N>"] = { "<Down>" },
        ["<C-B>"] = { "<Left>" },
        ["<C-F>"] = { "<Right>" },
        ["<C-A>"] = { "<Home>" },
        ["<C-E>"] = { "<End>" },
        ["<C-D>"] = { "<Del>" },
      },
      t = {
        ["<C-X>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true) },
      },
    },
    commands = {
      SudoWrite = {
        function()
          vim.cmd([[w !sudo tee % > /dev/null]])
        end,
      },
    },
    autocmds = {
      custom = {
        {
          event = "CursorHold",
          callback = function(args)
            local existing_float = vim.b[args.buf].lsp_floating_preview
            if existing_float and vim.api.nvim_win_is_valid(existing_float) then
              return
            end

            vim.diagnostic.open_float({ scope = "cursor" })
          end,
        },
        {
          event = { "BufEnter", "FocusGained", "InsertLeave", "WinEnter" },
          desc = "auto relativenumber on",
          callback = function()
            if vim.opt_local.number:get() then
              vim.opt_local.relativenumber = true
            end
          end,
        },
        {
          event = { "BufLeave", "FocusLost", "InsertEnter", "WinLeave" },
          desc = "auto relativenumber off",
          callback = function()
            if vim.opt_local.number:get() then
              vim.opt_local.relativenumber = false
            end
          end,
        },
        {
          event = "StdinReadPost",
          callback = function()
            vim.opt.modified = false
            vim.opt.mouse = "a"
          end,
        },
      },
    },
  },
}
