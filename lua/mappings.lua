-- Key mapper function, opts are optional
local map = require("helpers").keymapper

-- Basics
map("n", "U", "<C-r>", { desc = "Redo last action" }) -- Redo on U
map("n", "<esc>", "<cmd>noh<CR>") -- Clear search results
map("i", "<C-h>", "<C-w>", { desc = "Delete full word" }) -- Ctrl+Backspace delete word
map("n", "<PageUp>", "<C-u>", { desc = "Half page up" }) -- Half page up
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

-- Tmux window navigation
map("n", "<A-u>", "<cmd>TmuxNavigateUp<CR>", { desc = "Focus window up" })
map("n", "<A-e>", "<cmd>TmuxNavigateDown<CR>", { desc = "Focus window down" })
map("n", "<A-n>", "<cmd>TmuxNavigateLeft<CR>", { desc = "Focus window left" })
map("n", "<A-i>", "<cmd>TmuxNavigateRight<CR>", { desc = "Focus window right" })

-- Prev/next buffer navigation
map("n", "<leader>>", "<cmd>bn<CR>", { desc = "Go to next buffer" })
map("n", "<leader><", "<cmd>bp<CR>", { desc = "Go to prev buffer" })
map("n", "<leader>fn", "<cmd>bn<CR>", { desc = "Go to [N]ext buffer" })
map("n", "<leader>fp", "<cmd>bn<CR>", { desc = "Go to [P]rev buffer" })
map("n", "<leader>ff", "<cmd>e #<CR>", { desc = "Go to last buffer" })

-- Move lines up/down
map("n", "<C-Down>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<C-Up>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("i", "<C-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<C-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<C-Down>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "<C-Up>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- General Management
map("n", "<leader>fs", "<cmd>w<CR>", { desc = "Save current buffer" })
map("n", "<leader>fS", "<cmd>wa<CR>", { desc = "Save all buffers" })
-- https://stackoverflow.com/questions/1444322/how-can-i-close-a-buffer-without-closing-the-window
map("n", "<leader>xc", "<cmd>qa<CR>", { desc = "Exit Neovim" })
map("n", "<leader>xC", "<cmd>qa!<CR>", { desc = "Exit Neovim without saving" })

-- Extra tools
map("n", "<leader>xil", "<cmd>LspInfo<cr>", { desc = "[L]SP info" })
map("n", "<leader>xiz", "<cmd>Lazy<cr>", { desc = "La[z]y menu" })
map("n", "<leader>xim", "<cmd>Mason<cr>", { desc = "[M]ason menu" })
map("n", "<leader>xin", "<cmd>NullLsInfo<cr>", { desc = "[N]ullLs info" })
map("n", "<leader>xit", "<cmd>TSInstallInfo<cr>", { desc = "[T]reesitter info" })
map("n", "<leader>xic", "<cmd>ConformInfo<cr>", { desc = "[C]onform info" })

-- Window management
map("n", "<leader>wn", "<C-w>h", { desc = "Focus window left" })
map("n", "<leader>wu", "<C-w>k", { desc = "Focus window up" })
map("n", "<leader>we", "<C-w>j", { desc = "Focus window down" })
map("n", "<leader>wi", "<C-w>l", { desc = "Focus window right" })
map("n", "<leader>ww", "<C-w>p", { desc = "Focus next window" })
map("n", "<leader>wN", "<C-w>H", { desc = "Move window left" })
map("n", "<leader>wU", "<C-w>K", { desc = "Move window up" })
map("n", "<leader>wE", "<C-w>J", { desc = "Move window down" })
map("n", "<leader>wI", "<C-w>L", { desc = "Move window right" })
map("n", "<leader>ww", "<C-w>p", { desc = "Focus next window" })

map("n", "<leader>ws", "<C-w>s", { desc = "Split window horizontal" })
map("n", "<leader>wv", "<C-w>v", { desc = "Split window vertical" })
map("n", "<leader>w,", "<C-w>s", { desc = "Split window horizontal" })
map("n", "<leader>w.", "<C-w>v", { desc = "Split window vertical" })
map("n", "<leader>wm", "<C-w><bar><C-w>_", { desc = "Maximize window" })
map("n", "<leader>wM", "<C-w>=", { desc = "Restore windows size" })
map("n", "<leader>wc", "<C-w>c", { desc = "Close window" })
map("n", "<leader>wd", "<C-w>c", { desc = "Close window" })

-- Terminal management
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Diagnostics

-- Helper function
local diagnostic_goto = function(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
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
map("i", "<C-'>", "<cmd>ToggleTerm direction=horizontal name=default<CR>", { desc = "Default terminal" })
map("n", "<C-'>", "<cmd>ToggleTerm direction=horizontal name=default<CR>", { desc = "Default terminal" })
map("n", "<leader>tt", "<cmd>ToggleTerm direction=horizontal name=default<CR>", { desc = "Default terminal" })
map("n", "<leader>to", "<cmd>TermSelect<CR>", { desc = "Select terminal" })

-- Persistence mappings
map("n", "<leader>pr", "<cmd>lua require('persistence').load()<cr>", { desc = "[P]ersistence [R]estore" })
map("n", "<leader>ps", "<cmd>lua require('persistence').stop()<cr>", { desc = "[P]ersistence [S]top saving session" })
