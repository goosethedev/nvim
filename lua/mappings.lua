-- Key mapper function, opts are optional
local map = require("helpers").keymapper

-- Basic
map("n", "U", "<C-r>")          -- Redo on U
map("n", "<esc>", ":noh<CR>")   -- Clear search results
map("n", "<PageUp>", "<C-u>")   -- Half page up
map("n", "<PageDown>", "<C-d>") -- Half page down

-- Navigate in wrapped lines as if they were physical ones
map("n", "<Up>", "g<Up>")
map("n", "<Down>", "g<Down>")
map("i", "<Up>", "<C-o>g<Up>")
map("i", "<Down>", "<C-o>g<Down>")

-- General Management
map("n", "<leader>xs", ":w<CR>", { desc = "Save current buffer" })
map("n", "<leader>xS", ":wa<CR>", { desc = "Save all buffers" })
-- https://stackoverflow.com/questions/1444322/how-can-i-close-a-buffer-without-closing-the-window
map("n", "<leader>xk", ":bp<bar>sp<bar>bn<bar>bd<CR>", { desc = "Close buffer" })
map("n", "<leader>xK", ":bdel!<CR>", { desc = "Close buffer without saving" })
map("n", "<leader>xc", ":qa<CR>", { desc = "Exit Neovim" })
map("n", "<leader>xC", ":qa!<CR>", { desc = "Exit Neovim without saving" })

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
map("n", "<leader>wm", "<C-w><bar><C-w>_", { desc = "Maximize window" })
map("n", "<leader>wM", "<C-w>=", { desc = "Restore windows size" })
map("n", "<leader>wc", "<C-w>c", { desc = "Close window" })
map("n", "<leader>wc", "<C-w>d", { desc = "Close window" })

-- Terminal management
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
