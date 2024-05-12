return {
	-- Detect tabstop and shiftwidth automatically
	-- Disabled. Messes with tabs and spaces
	-- "tpope/vim-sleuth",

	-- "gc" to comment visual regions/lines
	{ "numToStr/Comment.nvim", opts = {} },

	{ -- Dashboard at startup
		"goolord/alpha-nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("alpha").setup(require("alpha.themes.theta").config)
		end,
	},
}
