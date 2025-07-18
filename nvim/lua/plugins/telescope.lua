return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.8',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
		vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Telescope buffers' })
		vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
		vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Telescope grep current word' })
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
		vim.keymap.set('n', '<leader>ft', builtin.builtin, { desc = 'Telescope builtin' })
		vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Telescope diagnostics' })
		vim.keymap.set(
			'n', '<leader>fc',
			function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end,
			{ desc = 'Telescope find config files' })
	end
}
