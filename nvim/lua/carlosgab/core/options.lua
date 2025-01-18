vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

-- termguicolors
opt.termguicolors = true

-- line numbers
opt.number = true
opt.relativenumber = true

-- tabs and infentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- wraping
opt.wrap = false

-- undo config
opt.swapfile = false
opt.backup = false
opt.undodir = { os.getenv("HOME") .. "/.vim/undodir" }
opt.undofile = true

-- search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- cursorline
opt.cursorline = true

-- turn on termguicolors
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- split windows
opt.splitright = true
opt.splitbelow = true
