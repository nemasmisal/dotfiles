return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
	opts = {
		ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "html", "typescript" },
		sync_install = false,
		auto_install = true,
		highlight = { enable = true },
		indent = { enable = true },
	}
}
