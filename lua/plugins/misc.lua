return {
	-- Detect tabstop and shiftwidth automatically
	-- Disabled. Messes with tabs and spaces
	-- "tpope/vim-sleuth",

	-- Tmux integration
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	},

	{ -- Close buffers
		-- TODO: closing a buffer sometimes closes the whole Neovim instance
		"Asheq/close-buffers.vim",
		keys = {
			{ "<leader>fd", "<cmd>Bdelete this<cr>", desc = "Close current buffer" },
			{ "<leader>fD", "<cmd>Bdelete hidden<cr>", desc = "Close all non-visible buffers" },
		},
	},

	-- "gc" to comment visual regions/lines
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})

			-- Set comment characters for unknown files
			local ft = require("Comment.ft")
			ft.set("kdl", "//%s")

			-- Custom mapping to <leader> + ';'
			vim.keymap.set(
				"n",
				"<leader>;",
				require("Comment.api").toggle.linewise.current,
				{ desc = "Toggle comment linewise" }
			)
		end,
		dependencies = {
			{
				"JoosepAlviste/nvim-ts-context-commentstring",
				opts = { enable_autocmd = false },
			},
		},
	},

	{ -- Dashboard at startup
		"goolord/alpha-nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"nvim-lua/plenary.nvim",
		},
		enabled = false,
		config = function()
			require("alpha").setup(require("alpha.themes.theta").config)
		end,
	},
}
