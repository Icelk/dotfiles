local g = vim.g
local o = vim.o

o.termguicolors = true
-- o.background = 'dark'

o.notimeout = true
o.ttimeout = true
o.updatetime = 300

-- Number of screen lines to keep above and below the cursor
o.scrolloff = 8

-- Better editor UI
o.number = true
o.relativenumber = true
o.signcolumn = 'yes:1'
o.cursorline = true
o.mouse = "a"

-- Better editing experience
o.expandtab = true
o.smarttab = true
o.cindent = true
o.autoindent = true
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = -1 -- If negative, shiftwidth value is used
o.list = true
o.listchars = 'trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂'

-- Makes neovim and host OS clipboard play nicely with each other
o.clipboard = 'unnamedplus'

-- Case insensitive searching UNLESS /C or capital in search
o.ignorecase = true
o.smartcase = true

-- Better buffer splitting
o.splitright = true
o.splitbelow = true

-- Map <leader> to ,
g.mapleader = ','
g.maplocalleader = ' '

o.fdm = "syntax"
o.signcolumn = "number"

-- o.spell = true
o.spelllang = "en_gb,sv"
