-- Mappings
local mappings_fn = function()
	local map = require("helpers").keymapper
	local builtin = require("telescope.builtin")

	map("n", "<leader>.", builtin.find_files, { desc = "Quick file open" })
	map("n", "<leader>:", builtin.command_history, { desc = "Search Command History" })
	map("n", "<leader>/", builtin.live_grep, { desc = "Search by Grep globally" })
	map("n", "<leader>sB", builtin.builtin, { desc = "[S]earch Telescope [B]uiltins" })
	map("n", "<leader>sc", builtin.commands, { desc = "[S]earch [C]ommands available" })
	map("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
	map("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
	map("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
	map("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
	map("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })

	-- Diagnostics
	map("n", "<leader>sD", builtin.diagnostics, { desc = "[S]earch [D]iagnostics globally" })
	map("n", "<leader>sd", function()
		builtin.diagnostics({ bufnr = 0 })
	end, { desc = "[S]earch [D]iagnostics in buffer" })

	-- Git related
	map("n", "<leader>sgf", builtin.git_files, { desc = "[G]it [F]iles" })
	map("n", "<leader>sgc", builtin.git_files, { desc = "[G]it [C]ommits" })
	map("n", "<leader>sgs", builtin.git_files, { desc = "[G]it [S]tatus" })

	-- Word search
	map("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
	map("n", "<leader>sW", function()
		builtin.grep_string({ word_match = "-w" })
	end, { desc = "[S]earch current [W]ord (Exact match)" })

	-- Search open buffers sorted by last opened
	map("n", "<leader><leader>", function()
		builtin.buffers({ sort_mru = true, sort_lastused = true })
	end, { desc = "Find opened buffer" })

	-- Search in current buffer
	map("n", "<leader>sB", function()
		-- You can pass additional configuration to Telescope to change the theme, layout, etc.
		builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
			winblend = 10,
			previewer = false,
		}))
	end, { desc = "[S]earch in current [B]uffer" })

	-- It's also possible to pass additional configuration options.
	--  See `:help telescope.builtin.live_grep()` for information about particular keys
	map("n", "<leader>so", function()
		builtin.live_grep({
			grep_open_files = true,
			prompt_title = "Live Grep in Open Files",
		})
	end, { desc = "[S]earch in [O]pen Files" })

	-- Shortcut for searching your Neovim configuration files
	map("n", "<leader>sn", function()
		builtin.find_files({ cwd = vim.fn.stdpath("config") })
	end, { desc = "[S]earch [N]eovim files" })
end

-- Flash search function
local function flash(prompt_bufnr)
	require("flash").jump({
		pattern = "^",
		label = { after = { 0, 0 } },
		search = {
			mode = "search",
			exclude = {
				function(win)
					return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
				end,
			},
		},
		action = function(match)
			local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
			picker:set_selection(match.pos[1] - 1)
		end,
	})
end

-- Entire config function
local config_fn = function(_, opts)
	-- Setup Telescope
	require("telescope").setup({
		-- Flash mappings using the flash function
		defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
			mappings = { n = { h = flash }, i = { ["<c-h>"] = flash } },
		}),
		-- Extensions
		extensions = {
			["ui-select"] = {
				require("telescope.themes").get_dropdown(),
			},
		},
	})

	-- Enable Telescope extensions if they are installed
	pcall(require("telescope").load_extension, "fzf")
	pcall(require("telescope").load_extension, "ui-select")

	-- Setup mappings
	mappings_fn()
end

return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.6",
	event = "VimEnter",
	config = config_fn,
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
