---@type LazySpec
return {
  { "tpope/vim-abolish" },
  { "tpope/vim-fugitive" },

  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },

  {
    "haya14busa/vim-asterisk",
    config = function()
      vim.keymap.set("", "*", [[<Plug>(asterisk-z*)]], {})
    end,
  },

  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter" },
    keys = {
      {
        "gJ",
        function()
          require("treesj").join()
        end,
      },
      {
        "gS",
        function()
          require("treesj").split()
        end,
      },
    },
    config = function()
      local treesj = require("treesj")

      treesj.setup({
        use_default_keymaps = false,
      })
    end,
  },

  {
    "lth-go/nvim-expand-region",
    opts = {},
  },

  {
    "chaoren/vim-wordmotion",
    init = function()
      vim.g.wordmotion_mappings = {
        ["w"] = "<M-w>",
        ["b"] = "<M-b>",
        ["e"] = "<M-e>",
        ["aw"] = "a<M-w>",
        ["iw"] = "i<M-w>",
      }
    end,
  },

  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    opts = {
      preview = {
        auto_preview = false,
      },
    },
  },

  {
    "lth-go/nvim-pqf",
    opts = {
      path_display = function(filename)
        return require("pkg.settings").path_display(filename)
      end,
    },
  },

  {
    "lth-go/searchx.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    keys = {
      {
        "/",
        function()
          require("searchx.command").search_raw()
        end,
        silent = true,
      },
    },
    config = function() end,
  },

  {
    "lth-go/mru.nvim",
    config = function()
      require("mru").setup({})

      vim.keymap.set("n", "<Leader>fm", function()
        require("snacks").picker.pick("MRU", {
          limit = 20,
          format = "file",
          finder = require("mru.picker").mru,
        })
      end)
    end,
  },

  {
    "windwp/nvim-autopairs",
    opts = {
      enabled = function()
        return true
      end,
    },
  },

  {
    "mistweaverco/kulala.nvim",
    ft = { "http" },
    keys = {
      {
        "<F5>",
        function()
          require("kulala").run()
        end,
        ft = { "http" },
      },
    },
    opts = {},
  },
}
