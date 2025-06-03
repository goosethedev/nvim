return {
	{ -- Best theme ever
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		opts = {
			transparent_background = true,
		},
		priority = 1000,
		init = function()
			vim.cmd.colorscheme("catppuccin")
		end,
		opts = {
			transparent_background = true,
		},
	},
}
