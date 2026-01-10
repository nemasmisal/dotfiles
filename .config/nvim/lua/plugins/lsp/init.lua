local vim = vim
return {
	"neovim/nvim-lspconfig",
	lazy = false,
	opts = {
		automatic_installation = true,
		ensure_installed = { "lua_ls", "angularls", "tsserver", "clangd", "prettier", "eslint_d" },
	},
	dependencies = {
		{
			"williamboman/mason.nvim",
			build = ":MasonUpdate",
			opts = {
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			},
		},
		"williamboman/mason-lspconfig.nvim",
	},
	keys = {
		{ mode = "n", "<space>e", vim.diagnostic.open_float },
		{ mode = "n", "[d", vim.diagnostic.goto_prev },
		{ mode = "n", "]d", vim.diagnostic.goto_next },
		{ mode = "n", "<leader>q", vim.diagnostic.setloclist },
	},
	config = function()
		local lsp_flags = {
			debounce_text_changes = 300,
		}

		local on_attach = function(_, bufnr)
			vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
			local bufopts = { noremap = true, silent = true, buffer = bufnr }
			vim.keymap.set("n", "gy", vim.lsp.buf.declaration, bufopts)
			vim.keymap.set("n", "gd", vim.lsp.buf.definition)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
			vim.keymap.set("n", "gr", vim.lsp.buf.references)
			-- vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
			vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
		end

		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		vim.lsp.enable("lua_ls")
		vim.lsp.config("lua_ls", {})

		vim.lsp.enable("angularls")
		vim.lsp.config("angularls", {
			on_attach = on_attach,
			capabilities = capabilities,
			filetypes = { "javascript", "typescript", "html", "htmlangular" },
			flags = lsp_flags,
		})

		vim.lsp.enable("ts_ls")
		vim.lsp.config("ts_ls", {
			on_attach = on_attach,
			capabilities = capabilities,
			filetypes = { "javascript", "typescript" },
			flags = lsp_flags,
		})

		vim.lsp.enable("clangd")
		vim.lsp.config("clangd", {
			filetypes = { "c" },
			on_attach = on_attach,
			capabilities = capabilities,
		})

		vim.lsp.enable("clangd")
		vim.lsp.config("clangd", {
			filetypes = { "c" },
			on_attach = on_attach,
			capabilities = capabilities,
		})
	end,
}
