local lsp_zero = require('lsp-zero')

lsp_zero.format_on_save({
	format_opts = {
		async = false,
		timeout_ms = 10000,
	},
	servers = {
		['rust_analyzer'] = { 'rust' },
		['ts_ls'] = { 'javascript', 'typescript' },
		['lua_ls'] = { 'lua' },
	}
})

lsp_zero.on_attach(function(_, bufnr)
	lsp_zero.default_keymaps({ buffer = bufnr })
end)

require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = {},
	handlers = {
		function(server_name)
			require('lspconfig')[server_name].setup({})
		end,
	},
})

require('lspconfig').gdscript.setup({})

local cmp = require('cmp')

cmp.setup({
	preselect = 'item',
	completion = {
		completeopt = 'menu,menuone,noinsert'
	},
})
