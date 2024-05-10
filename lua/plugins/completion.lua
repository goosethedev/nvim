return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"saadparwaiz1/cmp_luasnip", -- From Luasnip engine
		"hrsh7th/cmp-nvim-lsp", -- From LSP
		"hrsh7th/cmp-path", -- From file paths
		"hrsh7th/cmp-buffer", -- From words in buffer

		{ -- Luasnip snippets engine
			"L3MON4D3/LuaSnip",
			dependencies = "rafamadriz/friendly-snippets",

			build = (function()
				-- Build Step is needed for regex support in snippets.
				-- This step is not supported in many windows environments.
				-- Remove the below condition to re-enable on windows.
				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
					return
				end
				return "make install_jsregexp"
			end)(),
		},
	},
	config = require("configs.cmp"),
}
