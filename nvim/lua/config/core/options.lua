local opt = vim.opt

-- title
opt.title = true

-- command feature
opt.showcmd = true
opt.cmdheight = 0
opt.laststatus = 0

-- encoding
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- line numbers
opt.number = true
opt.relativenumber = true

-- tabs and indentation
opt.expandtab = false
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.autoindent = true
opt.smartindent = true
opt.smarttab = true

-- wraping
opt.wrap = false

-- undo config
opt.swapfile = false
opt.backup = false
opt.undodir = vim.fn.stdpath("data") .. "/undo"
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
opt.inccommand = "split"
opt.splitkeep = "cursor"
opt.splitright = true
opt.splitbelow = true

-- break comments
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		opt.formatoptions:remove("r")
	end,
})

-- search
opt.path:append("**")
opt.wildignore:append("*/node_modules/*")
