return {
	{
		"rebelot/kanagawa.nvim",
		config = function()
			require('kanagawa').setup({
				compile = true,
				-- 	theme = 'dragon'
			})
			vim.cmd("colorscheme kanagawa-dragon")
		end,
		build = function()
			vim.cmd("KanagawaCompile")
		end
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			options = {
				theme = "codedark"
			}
		}
	}
}
