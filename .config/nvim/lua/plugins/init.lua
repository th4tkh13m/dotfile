local present, packer = pcall(require, "plugins.packerInit")

if not present then
   return false
end

local use = packer.use

return packer.startup(function()
   local status = require("core.utils").load_config().plugins.status

   -- FUNCTION: override_req, use `chadrc` plugin config override if present
   -- name = name inside `default_config` / `chadrc`
   -- default_req = run this if 'name' does not exist in `default_config` / `chadrc`
   -- if override or default_req start with `(`, then strip that and assume override calls a function, not a whole file
   local override_req = function(name, default_req)
      local override = require("core.utils").load_config().plugins.default_plugin_config_replace[name]
      local result

      if override == nil then
         result = default_req
      else
         result = override
      end

      if string.match(result, "^%(") then
         result = result:sub(2)
         result = result:gsub("%)%.", "').", 1)
         return "require('" .. result
      else
         return "require('" .. result .. "')"
      end
   end

   -- this is arranged on the basis of when a plugin starts

  use {'th4tkh13m/onenord.nvim',
   config = function()
  	   vim.g.nord_disable_background = true
  	   vim.g.nord_italic = true
  	   require("onenord").set()
   end,
   after = "packer.nvim"
   }

    use {'hoob3rt/lualine.nvim',
    config = function()
      require 'lualine'.setup {
        options = {theme = 'nightfly'}
      }
    end,
    after = 'onenord.nvim'
    }
  use("nathom/filetype.nvim")


  use {
      "nvim-lua/plenary.nvim",
   }


   use {
      "wbthomason/packer.nvim",
      event = "VimEnter",
      config = function ()
          require('packer_compiled')
      end
   }
-- use {
--       "akinsho/bufferline.nvim",
--       disable = not status.bufferline,
--       after = "packer.nvim",
--       config = function ()
--         require("bufferline").setup{}
--       end,
--       setup = function()
--          require("core.mappings").bufferline()
--       end,
--    }


  use {
      "phaazon/hop.nvim",
      cmd = {
         "HopWord",
         "HopLine",
         "HopChar1",
         "HopChar2",
         "HopPattern",
      },
      as = "hop",
      config = function()
         require("hop").setup()
      end,
      setup = function ()
         require("core.mappings").hop()
      end
   }

  use {
    "tpope/vim-fugitive",
    cmd = "Git"
  }

   use {
      "lukas-reineke/indent-blankline.nvim",
      disable = not status.blankline,
      event = "BufRead",
      config = override_req("indent_blankline", "(plugins.configs.others).blankline()"),
   }


  use {
       "Pocco81/AutoSave.nvim",
       event = "InsertEnter",
       config = function()
         require("plugins.configs.autosave")
       end,
    }


   use {
      "karb94/neoscroll.nvim",
       opt = true,
       config = function()
          require("neoscroll").setup()
       end,

       -- lazy loading
       setup = function()
         require("core.utils").packer_lazy_load "neoscroll.nvim"
       end,
  }


   use {
      "Pocco81/TrueZen.nvim",
      cmd = {
         "TZAtaraxis",
         "TZMinimalist",
         "TZFocus",
      },
      config = function()
        require('plugins.configs.true_zen')
      end,
      setup = function()
         require("core.mappings").true_zen()
      end,
   }


   use {
       'anufrievroman/vim-angry-reviewer',
       cmd = "AngryReviewer",
       config = function ()
           vim.g.AngryReviewerEnglish = 'american'
       end,
       setup = function ()
           require("core.mappings").angry_reviewer()
       end,
   }

   use 'lewis6991/impatient.nvim'

   use {
      "nvim-treesitter/nvim-treesitter",
      branch = "0.5-compat",
      event = "BufRead",
      config = override_req("nvim_treesitter", "plugins.configs.treesitter"),
   }

   -- git stuff
   use {
      "lewis6991/gitsigns.nvim",
      disable = not status.gitsigns,
      opt = true,
      config = override_req("gitsigns", "plugins.configs.gitsigns"),
      setup = function()
         require("core.utils").packer_lazy_load "gitsigns.nvim"
      end,
   }

   -- lsp stuff

   use {
      "neovim/nvim-lspconfig",
      opt = true,
      setup = function()
         require("core.utils").packer_lazy_load "nvim-lspconfig"
         -- reload the current file so lsp actually starts for it
         vim.defer_fn(function()
            vim.cmd 'if &ft == "packer" | echo "" | else | silent! e %'
            vim.api.nvim_exec( [[
                    augroup jdtls_lsp
                    autocmd!
                    autocmd FileType java lua require'plugins.configs.lspconfig'.setup()
                    augroup end
            ]], true)
         end, 0)
      end,
      config = override_req("lspconfig", "plugins.configs.lspconfig"),
   }
   use {'mfussenegger/nvim-jdtls',
	ft = {'java', 'jar'},
      	}

    use 'williamboman/nvim-lsp-installer'

   use {
      "ray-x/lsp_signature.nvim",
      disable = not status.lspsignature,
      after = "nvim-lspconfig",
      config = override_req("signature", "(plugins.configs.others).signature()"),
   }

   use {
      "andymass/vim-matchup",
      disable = not status.vim_matchup,
      opt = true,
      setup = function()
         require("core.utils").packer_lazy_load "vim-matchup"
      end,
   }

   use {
      "max397574/better-escape.nvim",
      disable = not status.esc_insertmode,
      event = "InsertEnter",
      config = override_req("better_escape", "(plugins.configs.others).better_escape()"),
   }

   -- load luasnips + cmp related in insert mode only

   use {
      "rafamadriz/friendly-snippets",
      disable = not status.cmp,
      event = "InsertEnter",
   }

   use {
      "hrsh7th/nvim-cmp",
      disable = not status.cmp,
      after = "friendly-snippets",
      config = override_req("nvim_cmp", "plugins.configs.cmp"),
   }

   use {
      "L3MON4D3/LuaSnip",
      disable = not status.cmp,
      wants = "friendly-snippets",
      after = "nvim-cmp",
      config = override_req("luasnip", "(plugins.configs.others).luasnip()"),
   }

   use {
      "saadparwaiz1/cmp_luasnip",
      disable = not status.cmp,
      after = "LuaSnip",
   }

   use {
      "hrsh7th/cmp-nvim-lua",
      disable = not status.cmp,
      after = "cmp_luasnip",
   }

   use {
      "hrsh7th/cmp-nvim-lsp",
      disable = not status.cmp,
      after = "cmp-nvim-lua",
   }

   use {
      "hrsh7th/cmp-buffer",
      disable = not status.cmp,
      after = "cmp-nvim-lsp",
   }

   use {
      "hrsh7th/cmp-path",
      disable = not status.cmp,
      after = "cmp-buffer",
   }
   -- misc plugins
   use {
      "windwp/nvim-autopairs",
      disable = not status.autopairs,
      after = "nvim-cmp",
      config = override_req("nvim_autopairs", "(plugins.configs.others).autopairs()"),
   }


   use {
      "terrortylor/nvim-comment",
      disable = not status.comment,
      cmd = "CommentToggle",
      config = override_req("nvim_comment", "(plugins.configs.others).comment()"),
      setup = function()
         require("core.mappings").comment()
      end,
   }

   -- file managing , picker etc
   use {
      "kyazdani42/nvim-tree.lua",
      disable = not status.nvimtree,
      cmd = { "NvimTreeToggle", "NvimTreeFocus" },
      config = override_req("nvim_tree", "plugins.configs.nvimtree"),
      setup = function()
         require("core.mappings").nvimtree()
      end,
   }

   use {
      "nvim-telescope/telescope.nvim",
      module = "telescope",
      cmd = "Telescope",
      requires = {
         {
            "nvim-telescope/telescope-fzf-native.nvim",
            run = "make",
         },
      },
      config = override_req("telescope", "plugins.configs.telescope"),
      setup = function()
         require("core.mappings").telescope()
      end,
   }

   require("core.hooks").run("install_plugins", use)
end)
