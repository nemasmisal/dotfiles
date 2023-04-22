require("mason").setup()
require("mason-lspconfig").setup({
  automatic_installation = true,
  ensure_installed = { "lua_ls", "cssls", "html", "angularls", "tsserver", "kotlin_language_server" }
})
local lspconfig = require('lspconfig')
local lsp_flags = {
  debounce_text_changes = 300,
}
local vim = vim

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gy', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references)
  vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local project_library_path = vim.loop.cwd().."/node_modules/@angular/language-service"
local cmd = {
  "ngserver",
  "--stdio",
  "--tsProbeLocations",
  project_library_path,
  "--ngProbeLocations",
  project_library_path,
  "--viewEngine",
  "--includeCompletionsWithSnippetText",
  "--includeAutomaticOptionalChainCompletions"
}

lspconfig['lua_ls'].setup {}

lspconfig['angularls'].setup{
  cmd = cmd,
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { 'javascript', 'typescript', 'html' },
  on_new_config = function(new_config)
    new_config.cmd = cmd
  end,
  flags = lsp_flags,
}

lspconfig['tsserver'].setup{
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {'javascript', 'typescript'},
    flags = lsp_flags,
}

local htmlCssCapabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig['html'].setup{
  capabilities = htmlCssCapabilities,
  filetypes = { 'html' }
}

lspconfig['cssls'].setup{
  capabilities = htmlCssCapabilities,
  filetypes = { 'css', 'scss' }
}

lspconfig['kotlin_language_server'].setup{}
