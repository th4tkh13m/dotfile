local dap = require('dap')

local function on_attach(_, bufnr)
	-- require "lsp_signature".on_attach({
	-- 	bind = true, -- This is mandatory, otherwise border config won't get registered.
	-- 	handler_opts = {
	-- 		border = "single"
	-- 	};
	--     }, bufnr)
   local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
   end
   local function buf_set_option(...)
      vim.api.nvim_buf_set_option(bufnr, ...)
   end

   local opts = { noremap = true, silent = true }
end
