return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = { "nvim-web-devicons" },
    config = function()
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1
	vim.opt.termguicolors = true

	require("nvim-tree").setup({
		sync_root_with_cwd	= true
	})
    end
}
