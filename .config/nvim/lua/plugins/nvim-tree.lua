local vim = vim
return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons"
	},
	config = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
		require("nvim-tree").setup {}
	end,
	keys = {
		{ mode = "n", "<c-t>", ":NvimTreeFindFileToggle<CR>" }
	}
}