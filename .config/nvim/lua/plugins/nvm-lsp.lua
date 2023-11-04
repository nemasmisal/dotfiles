local vim = vim
return {
"neovim/nvim-lspconfig",
lazy = false,
opts = {
	automatic_installation = true,
	ensure_installed = { "lua_ls", "cssls", "html", "angularls", "tsserver", "kotlin_language_server" },
},
keys = {
	{ mode = "n", "<space>e", vim.diagnostic.open_float },
	{ mode = "n", "[d", vim.diagnostic.goto_prev },
	{ mode = "n", "]d", vim.diagnostic.goto_next },
	{ mode = "n", "<leader>q", vim.diagnostic.setloclist }
},
config = function()
	local lspconfig = require('lspconfig')
	local lsp_flags = {
		debounce_text_changes = 300,
	}

	local on_attach = function(_, bufnr)
		vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
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

	lspconfig['lua_ls'].setup {}

	lspconfig['angularls'].setup{
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = { 'javascript', 'typescript', 'html' },
        root_dir = lspconfig.util.root_pattern('angular.json', '.git'),
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
	lspconfig['jdtls'].setup{}
	lspconfig['clangd'].setup{
		on_attach = on_attach,
		cmd = {
			"/usr/bin/clangd",
			"--background-index",
			"--pch-storage=memory",
			"--all-scopes-completion",
			"--pretty",
			"--header-insertion=never",
			"--j=4",
			"--inlay-hints",
			"--header-insertion-decorators",
			"--function-arg-placeholders",
			"--completion-style=detailed"
		},
		filetypes = {"c", "cpp", "objc", "objcpp"},
		init_option = { fallbackFlags = { "-std=c++2a" } },
		capabilities = capabilities
	}

end
}
