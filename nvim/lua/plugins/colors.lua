local function enable_transparency()
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
end

return {
	{
		"rebelot/kanagawa.nvim",
		config = function()
			require('kanagawa').setup({
				theme = 'dragon'
			})
			vim.cmd("colorscheme kanagawa-dragon")
		end
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			theme = "nordic"
		}
	}
}
