-- File explorer
return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	keys = {
		-- { "<leader>ft", ":Neotree filesystem toggle right<CR>", desc = "File [T]ree", silent = true },
		{ "<A-'>", ":Neotree filesystem toggle right<CR>", desc = "File [T]ree", silent = true },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window
	},
	opts = {
		close_if_last_window = true,
	},
}
