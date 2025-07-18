-- print('options')

vim.opt.number = true
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.breakindent = true

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.mouse = "a"
vim.opt.showmode = false -- status line plugin already shows it

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 10

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.diagnostic.config({
	virtual_text = true,   -- Show inline diagnostics
	signs = true,          -- Show signs in the gutter
	underline = true,      -- Underline the problematic code
	update_in_insert = false, -- Don't update diagnostics while typing
	severity_sort = true,  -- Sort by severity
})

vim.o.guifont = "Fira Code:h10"
