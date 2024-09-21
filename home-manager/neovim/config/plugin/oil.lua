require("oil").setup({
	float = {
		max_width = 100,
		max_height = 40,
	},
	delete_to_trash = true,
	keymaps = {
		["g?"] = "actions.show_help",
		["<CR>"] = "actions.select",
		["<leader>s"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
		["<leader>h"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
		["<leader>t"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
		["<leader>p"] = "actions.preview",
		["<leader>c"] = "actions.close",
		["<leader>l"] = "actions.refresh",
		["-"] = "actions.parent",
		["_"] = "actions.open_cwd",
		["`"] = "actions.cd",
		["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
		["gs"] = "actions.change_sort",
		["gx"] = "actions.open_external",
		["g."] = "actions.toggle_hidden",
		["g\\"] = "actions.toggle_trash",
	},
	use_default_keymaps = false,
})

vim.keymap.set("n", "-", require("oil").open_float, { desc = "Open parent directory" })
