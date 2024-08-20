return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	event = "VeryLazy",
	keys = {
		{ "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
		{ "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
	},
	config = function(_, opts)
		require("bufferline").setup(opts)
		-- Fix bufferline when restoring a session
		vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
			callback = function()
				vim.schedule(function()
					pcall(nvim_bufferline)
				end)
			end,
		})
	end,
	opts = {
		options = {
      -- stylua: ignore
      close_command = function(n) require("mini.bufremove").delete(n, false) end,
      -- stylua: ignore
      right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
			diagnostics = "nvim_lsp",
			always_show_bufferline = true,
			diagnostics_indicator = function(count, _, _, _)
				return "(" .. count .. ")"
			end,
			offsets = {
				{
					filetype = "neo-tree",
					text = "Neo-tree",
					highlight = "Directory",
					text_align = "left",
				},
			},
			themable = false,
			indicator = {
				icon = "▎", -- this should be omitted if indicator style is not 'icon'
				style = "icon",
			},
			buffer_close_icon = "󰅖",
			modified_icon = "●",
			close_icon = "",
			left_trunc_marker = "",
			right_trunc_marker = "",
			truncate_names = true, -- whether or not tab names should be truncated
			color_icons = true,
			separator_style = "slant",
		},
	},
}
