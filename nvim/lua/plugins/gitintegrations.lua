return {
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",         -- required
			"sindrets/diffview.nvim",        -- optional - Diff integration

			-- Only one of these is needed.
			"nvim-telescope/telescope.nvim", -- optional
			-- "ibhagwan/fzf-lua",              -- optional
			-- "echasnovski/mini.pick",         -- optional
			-- "folke/snacks.nvim",             -- optional
	},
	config = function()
		vim.keymap.set("n", "<leader>G", ":Neogit<CR>", {})
	end
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function ()
			require("gitsigns").setup()

			vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
		end
	}
}
