return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	opts = {
		options = {
			component_separators = { left = '•', right = '•' },
			section_separators = { left = "", right = "" }
		},
		sections = {
			lualine_a = { 'buffers' },
			lualine_b = { 'mode' },
			lualine_c = { 'branch', 'diff', 'diagnostics' },
			lualine_x = { 'encoding', 'fileformat', 'filetype' },
			lualine_y = { 'progress' },
			lualine_z = { 'location' }
		},
	}
};
