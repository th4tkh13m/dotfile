-- IMPORTANT NOTE : This is default config, so dont change anything here.
-- use custom/chadrc.lua instead

local M = {}
M.options, M.ui, M.mappings, M.plugins = {}, {}, {}, {}

-- non plugin normal, available without any plugins
M.options = {
   -- NeoVim/Vim options
   clipboard = "unnamedplus",
   cmdheight = 1,
   ruler = false,
   hidden = true,
   ignorecase = true,
   smartcase = true,
   mapleader = ",",
   mouse = "a",
   number = true,
   -- relative numbers in normal mode tool at the bottom of options.lua
   numberwidth = 2,
   relativenumber = false,
   expandtab = true,
   shiftwidth = 4,
   smartindent = true,
   tabstop = 4, -- Number of spaces that a <Tab> in the file counts for
   timeoutlen = 400,
   -- interval for writing swap file to disk, also used by gitsigns
   updatetime = 250,
   undofile = true, -- keep a permanent undo (across restarts)


}


-- these are plugin related options
M.plugins = {
   -- enable and disable plugins (false for disable)
   status = {
      -- bufferline = true, -- list open buffers up the top, easy switching too
      blankline = true, -- show code scope with symbols
      comment = true, -- easily (un)comment code, language aware
      esc_insertmode = true, -- map to <ESC> with no lag
      gitsigns = true, -- gitsigns in statusline
      lspsignature = true, -- lsp enhancements
      vim_matchup = true, -- % operator enhancements
      cmp = true,
      nvimtree = true,
      autopairs = true,
   },
   options = {
      lspconfig = {
         setup_lspconf = "", -- path of file containing setups of different lsps
      },
      nvimtree = {
         enable_git = 0,
      },
      luasnip = {
         snippet_path = {},
      },
      esc_insertmode_timeout = 300,
   },
   default_plugin_config_replace = {},
}

-- mappings -- don't use a single keymap twice --
-- non plugin mappings
M.mappings = {
   -- custom = {}, -- all custom user mappings
   -- close current focused buffer
   close_buffer = "<leader>x",
   copy_whole_file = "<C-a>", -- copy all contents of the current buffer
   line_number_toggle = "<leader>n", -- show or hide line number
   new_buffer = "<S-t>", -- open a new buffer
   new_tab = "<C-t>b", -- open a new vim tab
   save_file = "<C-s>", -- save file using :w
   -- navigation in insert mode, only if enabled in options
   insert_nav = {
      backward = "<C-h>",
      end_of_line = "<C-e>",
      forward = "<C-l>",
      next_line = "<C-k>",
      prev_line = "<C-j>",
      beginning_of_line = "<C-a>",
   },
   --better window movement
   window_nav = {
      moveLeft = "<C-h>",
      moveRight = "<C-l>",
      moveUp = "<C-k>",
      moveDown = "<C-j>",
   },

   window_resize = {
     resizeLeft = "<space>h",
     resizeRight = "<space>l",
     resizeUp = "<space>k",
     resizeDown = "<space>j",
   },

   -- terminal related mappings
   terminal = {
      -- multiple mappings can be given for esc_termmode and esc_hide_termmode
      -- get out of terminal mode
      esc_termmode = { "jk" }, -- multiple mappings allowed
      -- get out of terminal mode and hide it
      esc_hide_termmode = { "JK" }, -- multiple mappings allowed
      -- show & recover hidden terminal buffers in a telescope picker
      pick_term = "<leader>W",
      -- below three are for spawning terminals
      new_horizontal = "<leader>h",
      new_vertical = "<leader>v",
      new_window = "<leader>t",
   },

   tex = {
       compile = "<leader>cc",
       view = "<leader>cv",
   }

}

-- all plugins related mappings
M.mappings.plugins = {
  -- bufferline = {
  --     next_buffer = "<TAB>", -- next buffer
  --     prev_buffer = "<S-Tab>", -- previous buffer
  --  },

    angry_reviewer = {
        review = "<leader>r",
    },

  hop = {
    word = "<leader>w",
    line = "<leader>l",
    pattern = "<leader>/",
  },

   -- easily (un)comment code, language aware
   comment = {
      toggle = "<space>/" -- toggle comment (works on multiple lines)
   },

  true_zen = {
    minimalist = "<F1>",
    focus = "<F2>",
    ataraxis = "<F3>"

  },

   -- map to <ESC> with no lag
   better_escape = { -- <ESC> will still work
      esc_insertmode = { "jk" }, -- multiple mappings allowed
   },
   -- file explorer/tree
   nvimtree = {
      toggle = "<leader>q",
      focus = "<leader>e",
   },
   -- multitool for finding & picking things
   telescope = {
      buffers = "<leader>fb",
      find_files = "<leader>ff",
      find_hiddenfiles = "<leader>fa",
      git_commits = "<leader>cm",
      git_status = "<leader>gt",
      help_tags = "<leader>fh",
      live_grep = "<leader>fw",
      oldfiles = "<leader>fo",
   },
}

return M
