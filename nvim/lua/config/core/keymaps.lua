vim.g.mapleader = " "

local keymap = vim.keymap

-- explorer
keymap.set("n", "-", ":lua MiniFiles.open()<CR>", { desc = "Open parent directory" })

-- skip single character
keymap.set("n", "x", '"_x')

-- select all
keymap.set("n", "<C-a>", "ggVG")

-- save file and quit
keymap.set("n", "<leader>w", ":update<CR>", { noremap = true, silent = true, desc = "Save" })
keymap.set("n", "<leader>q", ":quit<CR>", { noremap = true, silent = true, desc = "Quit" })

-- tabs
keymap.set("n", "<leader>to", ":tabnew<CR>", { noremap = true, silent = true, desc = "Open new tab" })
keymap.set("n", "<leader>tc", ":tabclose<CR>", { noremap = true, silent = true, desc = "Close current tab" })
keymap.set("n", "<tab>", ":tabnext<CR>", { noremap = true, silent = true, desc = "Go to next tab" })
keymap.set("n", "<s-tab>tp", ":tabprevious<CR>", { noremap = true, silent = true, desc = "Go to previous tab" })
keymap.set(
	"n",
	"<leader>tf",
	":tabnew %<CR>",
	{ noremap = true, silent = true, desc = "Open current buffer in new tab" }
)

-- windows
keymap.set("n", "<leader>sh", "<C-w>s", { noremap = true, silent = true, desc = "Split window horizontally" })
keymap.set("n", "<leader>sv", "<C-w>v", { noremap = true, silent = true, desc = "Split window vertically" })
keymap.set("n", "<leader>se", "<C-w>=", { noremap = true, silent = true, desc = "Equalize splits" })
keymap.set("n", "<leader>sx", ":close<CR>", { noremap = true, silent = true, desc = "Close current split" })

-- move lines
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- better delete and paste
keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without replacing clipboard" })

keymap.set("n", "<leader>y", '"+y', { desc = "Paste to clipboard" })
keymap.set("n", "<leader>Y", '"+y', { desc = "Paste to clipboard" })
keymap.set("v", "<leader>y", '"+y', { desc = "Paste to clipboard" })

-- increment and decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })
