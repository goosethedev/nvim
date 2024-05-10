return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.6",
	event = "VimEnter",
	config = require("configs.telescope"),
	dependencies = {
		-- Lol don't know
		"nvim-lua/plenary.nvim",

		{ -- Faster searches
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},

		-- Set vim.ui.select to Telescope
		"nvim-telescope/telescope-ui-select.nvim",

		{ -- Useful for getting pretty icons, but requires a Nerd Font.
			"nvim-tree/nvim-web-devicons",
			enabled = vim.g.have_nerd_font,
		},
	},
}
