-- print('options')

vim.opt.number = true
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

vim.diagnostic.config({
	virtual_text = true,   -- Show inline diagnostics
	signs = true,          -- Show signs in the gutter
	underline = true,      -- Underline the problematic code
	update_in_insert = false, -- Don't update diagnostics while typing
	severity_sort = true,  -- Sort by severity
})

vim.o.guifont = "Fira Code:h12"
