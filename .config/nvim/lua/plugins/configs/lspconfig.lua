local overrides = require("core.hooks").createOverrides "lsp"

local function on_attach(_, bufnr)
   local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
   end
   local function buf_set_option(...)
      vim.api.nvim_buf_set_option(bufnr, ...)
   end

    vim.api.nvim_exec([[
	  augroup lsp_document_highlight
		autocmd!
		autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
		autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
	  augroup END
    ]], false)
   -- Enable completion triggered by <c-x><c-o>
   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

   -- Mappings.
   local opts = { noremap = true, silent = true }

   -- See `:help vim.lsp.*` for documentation on any of the below functions
   buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
   buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
   buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
   buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
   buf_set_keymap("n", "gk", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
   buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
   buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
   buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
   buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
   buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
   buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
   buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
   buf_set_keymap("n", "ge", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
   buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
   buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
   buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
   buf_set_keymap("n", "<space>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
   buf_set_keymap("v", "<space>ca", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
   properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
   },
}

-- replace the default lsp diagnostic symbols
local function lspSymbol(name, icon)
   vim.fn.sign_define("LspDiagnosticsSign" .. name, { text = icon, numhl = "LspDiagnosticsDefault" .. name })
end

lspSymbol("Error", "")
lspSymbol("Information", "")
lspSymbol("Hint", "")
lspSymbol("Warning", "")

local lsp_publish_diagnostics_options = overrides.get("publish_diagnostics", {
   virtual_text = {
      prefix = "",
      spacing = 0,
   },
   signs = true,
   underline = true,
   update_in_insert = false, -- update diagnostics insert mode
})
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
   vim.lsp.diagnostic.on_publish_diagnostics,
   lsp_publish_diagnostics_options
)
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
   border = "single",
})

-- suppress error messages from lang servers
vim.notify = function(msg, log_level, _opts)
   if msg:match "exit code" then
      return
   end
   if log_level == vim.log.levels.ERROR then
      vim.api.nvim_err_writeln(msg)
   else
      vim.api.nvim_echo({ { msg } }, true, {})
   end
end

-- requires a file containing user's lspconfigs

-- local addlsp_confs = require("core.utils").load_config().plugins.options.lspconfig.setup_lspconf
-- 
-- if string.len(addlsp_confs) ~= 0 then
--    require(addlsp_confs).setup_lsp(on_attach, capabilities)
-- end

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = on_attach,
		capabilities = capabilities,
    }
    server:setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
end)
local M = {}

function M.setup()
    local jdtls_on_attach = function(_, bufnr)
      require'jdtls.setup'.add_commands()
	  on_attach(_, bufnr)
      local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
      local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

      buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

--       -- Mappings.
      local opts = { noremap=true, silent=true }
--       -- Java specific
      buf_set_keymap("n", "<leader>di", "<Cmd>lua require'jdtls'.organize_imports()<CR>", opts)
      buf_set_keymap("n", "<leader>dt", "<Cmd>lua require'jdtls'.test_class()<CR>", opts)
      buf_set_keymap("n", "<leader>dn", "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", opts)
      buf_set_keymap("v", "<leader>de", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
      buf_set_keymap("n", "<leader>de", "<Cmd>lua require('jdtls').extract_variable()<CR>", opts)
      buf_set_keymap("v", "<leader>dm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts)
	  buf_set_keymap("n", "<leader>ca", "<Cmd>lua require'jdtls'.code_action()<CR>", opts)
	  buf_set_keymap("v", "<leader>ca", "<Cmd>lua require'jdtls'.code_action(true)<CR>", opts)
	  buf_set_keymap("n", "<space>r", "<Cmd>lua require'jdtls'.code_action(false, 'refactor')<CR>", opts)
	  buf_set_keymap("v", "<space>r", "<Cmd>lua require'jdtls'.code_action(true, 'refactor')<CR>", opts)
      buf_set_keymap("n", "<space>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)


    end

    local root_markers = {'gradlew', 'pom.xml', 'git'}
    local root_dir = require('jdtls.setup').find_root(root_markers)
    local home = os.getenv('HOME')

capabilities.workspace.configuration = true
    local workspace_folder = home .. "/.local/workspace/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
    local config = {
        flags = {
          allow_incremental_sync = true,
        };
        capabilities = capabilities,
        on_attach = on_attach,
    }

    config.settings = {
        java = {
          signatureHelp = { enabled = true };
          contentProvider = { preferred = 'fernflower' };
          completion = {
            favoriteStaticMembers = {
              "org.hamcrest.MatcherAssert.assertThat",
              "org.hamcrest.Matchers.*",
              "org.hamcrest.CoreMatchers.*",
              "org.junit.jupiter.api.Assertions.*",
              "java.util.Objects.requireNonNull",
              "java.util.Objects.requireNonNullElse",
              "org.mockito.Mockito.*"
            }
          };
          sources = {
            organizeImports = {
              starThreshold = 9999;
              staticStarThreshold = 9999;
            };
          };
          codeGeneration = {
            toString = {
              template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
            }
          };
          configuration = {
            runtimes = {
              {
                name = "JavaSE-17",
                path = home .. "/Java/jdk-17.0.1",
              },
            }
          };
        };
    }
    config.cmd = {'java-lsp', workspace_folder}
    config.on_attach = jdtls_on_attach
    config.on_init = function(client, _)
        client.notify('workspace/didChangeConfiguration', { settings = config.settings })
    end
    local extendedClientCapabilities = require'jdtls'.extendedClientCapabilities
    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
    config.init_options = {
      extendedClientCapabilities = extendedClientCapabilities;
    }

    -- Server
    require('jdtls').start_or_attach(config)
end

return M

