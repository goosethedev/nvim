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

-- Options
local options_fn = function()
	return {
		defaults = {
			vimgrep_arguments = {
				"rg",
				"-L",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
			},
			prompt_prefix = "   ",
			selection_caret = "  ",
			entry_prefix = "  ",
			initial_mode = "insert",
			selection_strategy = "reset",
			sorting_strategy = "ascending",
			layout_strategy = "horizontal",
			layout_config = {
				horizontal = {
					prompt_position = "top",
					preview_width = 0.55,
					results_width = 0.8,
				},
				vertical = {
					mirror = false,
				},
				width = 0.87,
				height = 0.80,
				preview_cutoff = 120,
			},
			file_ignore_patterns = { "node_modules" },
			path_display = { "truncate" },
			winblend = 0,
			border = {},
			borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
			color_devicons = true,
			set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		},
	}
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
	require("telescope").setup(
		-- Merge current opts and new ones
		vim.tbl_deep_extend("force", opts or {}, {
			defaults = {
				file_sorter = require("telescope.sorters").get_fuzzy_file,
				generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
				file_previewer = require("telescope.previewers").vim_buffer_cat.new,
				grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
				qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
				-- Developer configurations: Not meant for general override
				buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
				-- Flash mappings using the flash function
				mappings = { n = { h = flash }, i = { ["<c-h>"] = flash } },
			},

			-- Extensions
			extensions_list = { "themes", "terms" },
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})
	)

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
	opts = options_fn(),
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
