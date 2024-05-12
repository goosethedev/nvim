return {
	{ -- Best theme ever
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		init = function()
			vim.cmd.colorscheme("catppuccin")
		end,
	},

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

	{ -- File explorer
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		keys = {
			{ "<leader>ft", ":Neotree filesystem toggle right<CR>", desc = "File [T]ree", silent = true },
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
	},

	{ -- Status line
		"nvim-lualine/lualine.nvim",
		opts = {
			options = { globalstatus = true },
		},
		-- config = true,
	},

	{ -- Show pending keybinds
		"folke/which-key.nvim",
		event = "VimEnter",
		config = function()
			require("which-key").setup()

			-- Document existing key chains
			require("which-key").register({
				["g"] = { name = "+goto" },
				["gs"] = { name = "+surround" },
				["z"] = { name = "+fold" },
				["]"] = { name = "+next" },
				["["] = { name = "+prev" },
				["u"] = { name = "Undo last action" },
				[";"] = { name = "Next f/t char search" },
				[","] = { name = "Prev f/t char search" },
				["<leader>d"] = { name = "[D]iagnostics", _ = "which_key_ignore" },
				["<leader>f"] = { name = "[F]ile", _ = "which_key_ignore" },
				["<leader>g"] = { name = "[G]ile", _ = "which_key_ignore" },
				["<leader>l"] = { name = "[L]SP", _ = "which_key_ignore" },
				["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
				["<leader>sg"] = { name = "[S]earch [G]it", _ = "which_key_ignore" },
				["<leader>w"] = { name = "[W]indow", _ = "which_key_ignore" },
				["<leader>x"] = { name = "[X]tra / E[X]it", _ = "which_key_ignore" },
				["<leader>xi"] = { name = "Config [I]nfo", _ = "which_key_ignore" },
			})
		end,
	},

	{ -- Highlight todo, notes, etc in comments
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
	},
}
