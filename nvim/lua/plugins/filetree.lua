return {
	-- {
	-- 	"nvim-tree/nvim-tree.lua",
	-- 	version = "*",
	-- 	lazy = false,
	-- 	dependencies = { "nvim-web-devicons" },
	-- 	config = function()
	-- 		vim.g.loaded_netrw = 1
	-- 		vim.g.loaded_netrwPlugin = 1
	-- 		vim.opt.termguicolors = true
	--
	-- 		require("nvim-tree").setup({
	-- 			sync_root_with_cwd = true,
	-- 			git = {
	-- 				enable = true,
	-- 				ignore = false
	-- 			}
	-- 		})
	-- 	end
	-- },
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- Optional image support for file preview: See `# Preview Mode` for more information.
			-- {"3rd/image.nvim", opts = {}},
			-- OR use snacks.nvim's image module:
			-- "folke/snacks.nvim",
		},
		lazy = false, -- neo-tree will lazily load itself
		keys = {
			{ '<leader>e', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true }
		},
		---@module "neo-tree"
		---@type neotree.Config?
		opts = {
			-- add options here
			filesystem = {
				window = {
					mappings = {
						['<leader>e'] = 'close_window',
					},
				},
			},
		},
	}

}
