return {
	-- Detect tabstop and shiftwidth automatically
	-- Disabled. Messes with tabs and spaces
	-- "tpope/vim-sleuth",

	-- "gc" to comment visual regions/lines
	{ "numToStr/Comment.nvim", opts = {} },

	{ -- Better surround, inside, etc. as mini plugins
		"echasnovski/mini.nvim",
		config = require("configs.mini"),
	},

	{ -- Cmd tools as unified LSP
		"nvimtools/none-ls.nvim",
		event = "BufEnter",
		config = require("configs.none-ls"),
	},

	{ -- Search/replace in multiple files
		"nvim-pack/nvim-spectre",
		build = false,
		cmd = "Spectre",
		opts = { open_cmd = "noswapfile vnew" },
    -- stylua: ignore
    keys = {
      {
        "<leader>ss",
        function() require("spectre").open() end,
        desc = "[S]pectre: Replace in Files"
      },
    },
	},

	{ -- Autoformat
		"stevearc/conform.nvim",
		lazy = false,
		keys = {
			{
				"<leader>lf",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "LSP: [F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style.
				local disable_filetypes = { c = true, cpp = true }
				return {
					timeout_ms = 500,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform can also run multiple formatters sequentially
				-- python = { "isort", "black" },
				--
				-- You can use a sub-list to tell conform to run *until* a formatter
				-- is found.
				-- javascript = { { "prettierd", "prettier" } },
			},
		},
	},
}
