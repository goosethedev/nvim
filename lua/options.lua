local o = vim.o -- For primitive options (nums, bool, strs, etc)
local opt = vim.opt -- For table options (:append, :remove, etc)

-- Globals
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

-- Line numbers column
o.number = true
o.relativenumber = true
o.numberwidth = 2 -- Min columns on line numbers, will grow if needed
o.ruler = false -- Cursor position in statusline. Lualine does this for us
o.signcolumn = "yes" -- Prevent the text from sliding when signs reveal
o.colorcolumn = "80" -- Place a visual column line
o.cursorline = true -- Highlight cursor's current line
o.cursorlineopt = "number" -- But only the line number, not whole line

-- Statusline
-- o.laststatus = 3 -- Only one global statusline (Lualine takes care. DON'T uncomment)
o.showmode = false -- Don't show -- INSERT --

-- Indenting
o.expandtab = true -- Spaces instead of tabs
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.showtabline = 2
o.breakindent = true
o.smartindent = true

-- Window splitting
o.splitright = true
o.splitbelow = true

-- Searching
o.ignorecase = true -- Search case-insensitive
o.smartcase = true -- Except if uppercase is used
o.hlsearch = true -- Highlight search items
o.grepprg = "rg --vimgrep"
o.grepformat = "%f:%l:%c:%m"
o.inccommand = "split" -- Preview substitutions as you type!

-- Whitespace chars
o.list = false -- Don't show whitespace chars by default. They're annoying.
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Misc
o.clipboard = "unnamedplus" -- Use system clipboard
o.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
o.formatoptions = "jcroqlnt" -- Default: tcqj - See :h formatoptions
o.mouse = "a" -- Enable mouse
o.scrolloff = 10 -- Keep 10 lines up and down when scrolling
o.termguicolors = true -- 24-bit colors
o.timeoutlen = 400 -- Time to show Which key
opt.undofile = true -- Save undo changes in ~/.local/state/nvim/undo
opt.undolevels = 10000 -- Amount of undo actions to save
-- o.updatetime = 300 -- Time (ms) after standby to write swap file
o.wrap = true -- Text wrap
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.whichwrap:append("<>[]") -- Go to prev/next line on start/end is reached
