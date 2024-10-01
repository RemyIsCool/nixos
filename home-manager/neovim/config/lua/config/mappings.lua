vim.keymap.set("n", "<leader>o", "o<Esc>")
vim.keymap.set("n", "<leader>O", "O<Esc>")

vim.keymap.set("n", "<C-s>", "<Cmd>w<CR>")
vim.keymap.set("n", "<C-q>", "<Cmd>q<CR>")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

vim.api.nvim_set_keymap("n", "j", 'v:count ? "j" : "gj"', { noremap = true, expr = true })
vim.api.nvim_set_keymap("n", "k", 'v:count ? "k" : "gk"', { noremap = true, expr = true })

vim.keymap.set("n", "<C-c>", "<Cmd>noh<CR>")

vim.keymap.set("n", "<leader>lu", "<Cmd>Lazy update<CR>")

vim.keymap.set("n", "<leader>n", "<Cmd>bn<CR>")
vim.keymap.set("n", "<leader>p", "<Cmd>bp<CR>")
vim.keymap.set("n", "<leader>d", "<Cmd>bdelete<CR>")
