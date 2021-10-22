local opt = vim.opt
local g = vim.g
local options = require("core.utils").load_config().options
g.nvchad_user_config = "chadrc"
local default_options = {
	clipboard = "unnamedplus",
	conceallevel = 1,
	tabstop = 4,
	softtabstop = 4,
	shiftwidth = 4,
	smarttab = true,
	autoindent = true,
	encoding = "utf-8",
	textwidth = 0,
	signcolumn = "number",
	incsearch = true,
	ignorecase = true,
	smartcase = true,
	hlsearch = true,
	wildmode = "longest,list,full",
	wildmenu = true,
	wrap = false,
	breakindent = true,
	hidden = true,
	number = true,
	lazyredraw = true,
	showtabline = 2,
	updatetime = 300,
	spell = false,
    spelllang = "en",
    scrolloff = 8, -- is one of my fav
    sidescrolloff = 8,
	smartindent = true,
	mouse = "a",
	cursorline = true,
	relativenumber = false,
	pumheight = 10,
	showmode = false,
}
for k, v in pairs(default_options) do
    opt[k] = v
  end
-- disable nvim intro

opt.shortmess:append "sI"

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true


-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

g.mapleader = options.mapleader

-- disable some builtin vim plugins
local disabled_built_ins = {
   "2html_plugin",
   "getscript",
   "getscriptPlugin",
   "gzip",
   "logipat",
   "netrw",
   "netrwPlugin",
   "netrwSettings",
   "netrwFileHandlers",
   "matchit",
   "tar",
   "tarPlugin",
   "rrhelper",
   "spellfile_plugin",
   "vimball",
   "vimballPlugin",
   "zip",
   "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
   g["loaded_" .. plugin] = 1
end
g.python3_host_prog='/home/th4tkh13m/miniconda3/envs/myenv/bin/python3'
