return {
	"neovim/nvim-lspconfig",
	config = require("configs.lsp"),
	dependencies = {
		-- Manage LSP and cmd tools installation
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
    "jay-babu/mason-null-ls.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		-- Neovim Lua namespace completion
		{ "folke/neodev.nvim", opts = {} },

		-- Useful status updates for LSP
		{ "j-hui/fidget.nvim", opts = {} },
	},
}
