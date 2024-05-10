local opt = vim.opt
local o = vim.o
local g = vim.g

g.mapleader = " "
g.maplocalleader = " "
g.have_nerd_font = true

-- From NvChad
o.laststatus = 3
o.showmode = false -- Don't show -- INSERT --

o.clipboard = "unnamedplus"
o.cursorline = true
o.cursorlineopt = "number"

-- Line numbers
o.number = true
o.relativenumber = true
o.numberwidth = 2
o.ruler = false

-- Indenting
o.expandtab = true
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.showtabline = 2
o.breakindent = true
o.smartindent = true

-- Better splitting
o.splitright = true
o.splitbelow = true

-- Better search
o.ignorecase = true -- Search case-insensitive
o.smartcase = true -- Except if uppercase is used
o.hlsearch = true -- Highlight search items
o.grepprg = "rg --vimgrep"
o.grepformat = "%f:%l:%c:%m"

-- Prevent the screen from jumping on signs
-- e.g. gitsigns, dap breakpoints, etc.
o.signcolumn = "yes"

-- Place a column line
o.colorcolumn = "80"

-- Preview substitutions live, as you type!
o.inccommand = "split"

-- Sets how neovim will display certain whitespace characters in the editor.
-- o.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- go to previous/next line with left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]")

-- Misc
o.wrap = true -- Text wrap
o.mouse = "a" -- Enable mouse
o.termguicolors = true -- 24-bit colors
o.scrolloff = 10 -- Keep 10 lines up and down when scrolling
o.timeoutlen = 300 -- Time to show Which key
-- o.updatetime = 300 -- Time (ms) after standby to write swap file
