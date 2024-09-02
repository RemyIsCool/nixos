require('nvim-treesitter.configs').setup {
	ensure_installed = { "rust", "bash", "javascript", "typescript", "gdscript", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
	sync_install = false,
	auto_install = true,

	highlight = {
		enable = true,

		additional_vim_regex_highlighting = false,
	},
}
