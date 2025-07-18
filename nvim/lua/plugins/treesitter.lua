return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			highlight = { enable = true },
			indent = { enable = true },
			autotage = { enable = true },
			sync_install = false,
			ignore_install = {},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<Enter>", -- set to `false` to disable one of the mappings
					node_incremental = "<Enter>",
					scope_incremental = false,
					node_decremental = "<Backspace>"
				},
			},
			ensure_installed = {
				"lua",
				"vim",
				"vimdoc",
				"bash",
				"powershell",
				"c",
				"cpp",
				"c_sharp",
				"java",
				"query",
				"markdown",
				"html",
				"css",
				"scss",
				"json",
				"toml",
				"csv",
				"javascript",
				"typescript",
				"sql",
				"ruby",
				"python",
				"v",
				"odin",
				"zig",
				"rust",
				"d"
			},
			auto_install = false,
		})
	end
}
