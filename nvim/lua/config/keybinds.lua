-- print('keybinds')

vim.g.mapleader = " "
-- vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)
-- vim.keymap.set("n", "<leader>cd", vim.cmd.NvimTreeToggle)

vim.keymap.set('n', '<F2>', ':w<CR>', {noremap = true, silent = true, desc = "Save buffer" })
vim.keymap.set('i', '<F2>', '<Esc>:w<CR>a', {noremap = true, silent = true, desc = "Save buffer" })


local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<A-h>', '<C-w>h', opts)
vim.keymap.set('n', '<A-j>', '<C-w>j', opts)
vim.keymap.set('n', '<A-k>', '<C-w>k', opts)
vim.keymap.set('n', '<A-l>', '<C-w>l', opts)
vim.keymap.set('i', '<A-h>', '<Esc><C-w>h', opts)
vim.keymap.set('i', '<A-j>', '<Esc><C-w>j', opts)
vim.keymap.set('i', '<A-k>', '<Esc><C-w>k', opts)
vim.keymap.set('i', '<A-l>', '<Esc><C-w>l', opts)


-- Yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
-- Paste from system clipboard
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste from system clipboard" })
