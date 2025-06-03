local map = require("helpers").keymapper

-- Autogroup creation helpers
local autocmd = vim.api.nvim_create_autocmd

local augroup = function(name)
	return vim.api.nvim_create_augroup("shima_" .. name, { clear = true })
end

-- Run Telescope file search on startup
-- Doesn't work and also a bad idea
-- autocmd("VimEnter", {
-- 	callback = function()
-- 		require("telescope.builtin").find_files()
-- 	end,
-- })

-- Check if we need to reload the file when it changed
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	desc = "Check if file needs to be reloaded",
	group = augroup("checktime"),
	callback = function()
		if vim.o.buftype ~= "nofile" then
			vim.cmd("checktime")
		end
	end,
})

-- Highlight on yank
autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Remove annoying format options for comments
-- https://www.reddit.com/r/neovim/comments/10keuug/comment/j5qa6a6
-- autocmd("BufEnter", {
-- 	group = augroup("FormatOptions"),
-- 	pattern = "*",
-- 	desc = "Set buffer local formatoptions.",
-- 	callback = function()
-- 		vim.opt_local.formatoptions:remove({
-- 			"r", -- Automatically insert the current comment leader after hitting <Enter> in Insert mode.
-- 			"o", -- Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
-- 		})
-- 	end,
-- })

-- Resize splits if window got resized
autocmd({ "VimResized" }, {
	desc = "Resize splits if window got resized",
	group = augroup("resize_splits"),
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})

-- Go to last loc when opening a buffer
autocmd("BufReadPost", {
	desc = "Go to last loc when opening a buffer",
	group = augroup("last_loc"),
	callback = function(event)
		local exclude = { "gitcommit" }
		local buf = event.buf
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
			return
		end
		vim.b[buf].lazyvim_last_loc = true
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Close some filetypes with <q>
autocmd("FileType", {
	desc = "Close some filetypes with <q>",
	group = augroup("close_with_q"),
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"notify",
		"qf",
		"query",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"neotest-output",
		"checkhealth",
		"neotest-summary",
		"neotest-output-panel",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		map("n", "q", "<cmd>close<cr>", { buffer = event.buf })
	end,
})

-- Close Telescope windows with <Esc>
autocmd("FileType", {
	desc = "Close Telescope with <Esc>",
	group = augroup("close_telescope_with_esc"),
	pattern = { "TelescopePrompt" },
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		map("i", "<Esc>", "<cmd>q!<cr>", { buffer = event.buf })
	end,
})

-- Make it easier to close man-files when opened inline
autocmd("FileType", {
	desc = "Make it easier to close man-files when opened inline",
	group = augroup("man_unlisted"),
	pattern = { "man" },
	callback = function(event)
		vim.bo[event.buf].buflisted = false
	end,
})

-- Wrap and check for spell in text filetypes
autocmd("FileType", {
	desc = "Wrap and check for spell in text filetypes",
	group = augroup("wrap_spell"),
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- Fix conceallevel for json files
autocmd({ "FileType" }, {
	desc = "Fix conceallevel for json files",
	group = augroup("json_conceal"),
	pattern = { "json", "jsonc", "json5" },
	callback = function()
		vim.opt_local.conceallevel = 0
	end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
-- Doesn't work, don't know what it does in the first place
-- autocmd({ "BufWritePre" }, {
-- 	desc = "Create intermediate directories if don't exist",
-- 	group = augroup("auto_create_dir"),
-- 	callback = function(event)
-- 		if event.match:match("^%w%w+:[\\/][\\/]") then
-- 			return
-- 		end
-- 		local file = vim.fs.realpath(event.match) or event.match
-- 		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
-- 	end,
-- })
