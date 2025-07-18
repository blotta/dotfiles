local default_on_attach = function(_, bufnr)
	local nmap = function(keys, func, desc)
		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	-- LSP basics
	nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	nmap("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
	nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Help")

	-- Diagnostics
	nmap("<leader>e", vim.diagnostic.open_float, "Open diagnostics")
	-- nmap("[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
	-- nmap("]d", vim.diagnostic.goto_next, "Next Diagnostic")
	nmap("<leader>q", vim.diagnostic.setloclist, "Diagnostics to Loclist")

	-- Format
	nmap("<leader><F8>", function()
		vim.lsp.buf.format({ async = true })
	end, "Format File")
end


return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			'saghen/blink.cmp',
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {

					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},
		config = function()
			local capabilities = require('blink.cmp').get_lsp_capabilities()
			local lsp = require("lspconfig")
			lsp.lua_ls.setup { capabilities = capabilities }
			lsp.clangd.setup { capabilities = capabilities, on_attach = default_on_attach }
			lsp.ruby_lsp.setup({
				capabilities = capabilities,
				init_options = {
					formatters = 'standard',
					linters = { 'standard' },
				}
			})
		end
	}

}
