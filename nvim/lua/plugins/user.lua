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
    "junegunn/vim-easy-align",
    init = function()
      vim.keymap.set("x", "ga", "<Plug>(EasyAlign)", {})
      vim.keymap.set("n", "ga", "<Plug>(EasyAlign)", {})
    end,
  },

  {
    "Wansmer/treesj",
    keys = { "gJ", "gS" },
    dependencies = { "nvim-treesitter" },
    config = function()
      local treesj = require("treesj")

      treesj.setup({
        use_default_keymaps = false,
      })

      vim.keymap.set("n", "gJ", treesj.join)
      vim.keymap.set("n", "gS", treesj.split)
    end,
  },

  {
    "terryma/vim-expand-region",
    dependencies = { "nvim-treesitter" },
    init = function()
      vim.g.expand_region_text_objects = {
        ["iw"] = 0,
        ['i"'] = 0,
        ["i'"] = 0,
        ["i`"] = 0,
        ["i)"] = 1,
        ["a)"] = 1,
        ["i]"] = 1,
        ["a]"] = 1,
        ["i}"] = 1,
        ["a}"] = 1,
        ["in"] = 1,
      }

      vim.keymap.set("v", "v", "<Plug>(expand_region_expand)", {})
      vim.keymap.set("v", "V", "<Plug>(expand_region_shrink)", {})

      vim.keymap.set("x", "in", function()
        local incremental_selection = require("nvim-treesitter.incremental_selection")

        for _ = 1, vim.v.count1 do
          incremental_selection.node_incremental()
        end
      end, { silent = true })
    end,
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
    keys = { "/" },
    config = function()
      vim.keymap.set("n", "/", require("searchx.command").search_raw, { silent = true })
    end,
  },

  {
    "lth-go/vim-translator",
    config = function()
      vim.g.translator_default_engines = { "google" }
      vim.g.translator_proxy_url = "http://192.168.56.1:7890"

      vim.keymap.set("n", "<Leader>t", [[<Plug>TranslateW]], { silent = true })
      vim.keymap.set("v", "<Leader>t", [[<Plug>TranslateWV]], { silent = true })
    end,
  },

  {
    "lth-go/mru.nvim",
    keys = {
      {
        "<Leader>fm",
        function()
          require("snacks").picker.pick("MRU", {
            limit = 20,
            format = "file",
            finder = function(opts, ctx)
              local current_file = vim.fs.normalize(vim.api.nvim_buf_get_name(0), { _fast = true })
              local cwd = vim.uv.cwd() .. "/"
              local limit = 20

              local files = require("mru").load()

              files = vim.tbl_filter(function(file)
                return vim.startswith(file, cwd)
              end, files)

              local results = {}
              local seen = {}

              for _, file in ipairs(files) do
                if not seen[file] and file ~= current_file then
                  local file_stat = vim.uv.fs_stat(file)
                  if file_stat and file_stat.type == "file" then
                    table.insert(results, file)
                    seen[file] = true

                    if #results >= limit then
                      break
                    end
                  end
                end
              end

              return function(cb)
                for _, file in ipairs(results) do
                  cb({ file = file, text = file })
                end
              end
            end,
          })
        end,
      },
    },
    opts = {},
  },
}
