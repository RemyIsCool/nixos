require("oil").setup({
	float = {
		max_width = 100,
		max_height = 40,
	},
	delete_to_trash = true,
})

vim.keymap.set("n", "-", require("oil").open_float, { desc = "Open parent directory" })
