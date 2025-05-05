-- Key mapper function, opts are optional
local map = require("helpers").keymapper
local all_modes = { "n", "i", "v" }

-- Basics
map("n", "U", "<C-r>", { desc = "Redo last action" }) -- Redo on U
map("n", "<esc>", "<cmd>noh<CR>") -- Clear search results
map("i", "<C-h>", "<C-w>", { desc = "Delete full word" }) -- Ctrl+Backspace delete word
map("n", "<PageUp>", "<C-u>", { desc = "half page up" }) -- Half page up
map("n", "<PageDown>", "<C-d>", { desc = "Half page down" }) -- Half page down

-- Comment next line on Insert mode when Shift+Return
-- Nope, doesn't work and can't be done - https://stackoverflow.com/a/16360063
-- map("i", "<S-Return>", "<Esc>gccA", { desc = "Auto comment next line" })

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Better search navigation
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Previous Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Previous Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Previous Search Result" })

-- Navigate in wrapped lines as if they were physical ones
map("n", "<Up>", "g<Up>")
map("n", "<Down>", "g<Down>")
map("i", "<Up>", "<C-o>g<Up>")
map("i", "<Down>", "<C-o>g<Down>")

-- Window management
map(all_modes, "<A-n>", "<C-w>h", { desc = "Focus window left" })
map(all_modes, "<A-u>", "<C-w>k", { desc = "Focus window up" })
map(all_modes, "<A-e>", "<C-w>j", { desc = "Focus window down" })
map(all_modes, "<A-i>", "<C-w>l", { desc = "Focus window right" })
map(all_modes, "<A-N>", "<C-w>H", { desc = "Move window left" })
map(all_modes, "<A-U>", "<C-w>K", { desc = "Move window up" })
map(all_modes, "<A-E>", "<C-w>J", { desc = "Move window down" })
map(all_modes, "<A-I>", "<C-w>L", { desc = "Move window right" })

map(all_modes, "<A-,>", "<C-w>s", { desc = "Split window horizontal" })
map(all_modes, "<A-.>", "<C-w>v", { desc = "Split window vertical" })
map(all_modes, "<A-m>", "<C-w><bar><C-w>_", { desc = "Maximize window" })
map(all_modes, "<A-M>", "<C-w>=", { desc = "Restore windows size" })
map(all_modes, "<A-w>", "<C-w>c", { desc = "Close window" })

-- Prev/next buffer navigation
map(all_modes, "<A-y>", "<cmd>bn<CR>", { desc = "Go to next buffer" })
map(all_modes, "<A-l>", "<cmd>bp<CR>", { desc = "Go to prev buffer" })
map(all_modes, "<A-Y>", "<cmd>BufferLineMoveNext<CR>", { desc = "Move buffer forward" })
map(all_modes, "<A-L>", "<cmd>BufferLineMovePrev<CR>", { desc = "Move buffer backward" })

-- Move lines up/down
map("n", "<A-Down>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<A-Up>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("i", "<A-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-Down>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-Up>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- General Management
map(all_modes, "<C-s>", "<cmd>w<CR>", { desc = "Save current buffer" })
map(all_modes, "<C-S>", "<cmd>wa<CR>", { desc = "Save all buffers" })
map(all_modes, "<A-q>", "<cmd>qa<CR>", { desc = "Exit Neovim" })
map(all_modes, "<A-Q>", "<cmd>qa!<CR>", { desc = "Exit Neovim without saving" })

-- Extra tools
map("n", "<leader>xil", "<cmd>LspInfo<cr>", { desc = "[L]SP info" })
map("n", "<leader>xiz", "<cmd>Lazy<cr>", { desc = "La[z]y menu" })
map("n", "<leader>xim", "<cmd>Mason<cr>", { desc = "[M]ason menu" })
map("n", "<leader>xin", "<cmd>NullLsInfo<cr>", { desc = "[N]ullLs info" })
map("n", "<leader>xit", "<cmd>TSInstallInfo<cr>", { desc = "[T]reesitter info" })
map("n", "<leader>xic", "<cmd>ConformInfo<cr>", { desc = "[C]onform info" })

-- Terminal management
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Diagnostics

-- Helper function
local diagnostic_goto = function(next, severity)
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		vim.diagnostic.jump({ count = next and 1 or -1, severity = severity, float = true })
	end
end

-- Navigate diagnostics
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- Terminal mappings
map({"n", "i"}, "<A-/>", "<cmd>ToggleTerm direction=horizontal name=default<CR>", { desc = "Default terminal" })
map("n", "<leader>to", "<cmd>TermSelect<CR>", { desc = "Select terminal" })

-- Persistence mappings
map("n", "<leader>pr", "<cmd>lua require('persistence').load()<cr>", { desc = "[P]ersistence [R]estore" })
map("n", "<leader>ps", "<cmd>lua require('persistence').stop()<cr>", { desc = "[P]ersistence [S]top saving session" })
