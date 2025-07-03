-- For any questions regarding options
-- You can use command: :opt
--

vim.o.winborder = 'rounded' --available in nvim 0.11

-- Search
vim.opt.incsearch = true
vim.opt.ignorecase = true --ignore case when using a search pattern
vim.opt.smartcase = true  --override 'ignorecase' when pattern has upper case characters

-- Wrap
vim.opt.wrap = false--true --long lines wrap

-- Numbers
vim.opt.number = true -- Show Line Numbers in BUFFER
vim.opt.relativenumber = true -- Show Relative Line Numbers in BUFFER

-- Cursor Highlight
--vim.opt.cursorcolumn = true	--highlight the screen column of the cursor
vim.opt.cursorline = true --highlight the screen line of the cursor

--Spelling
--vim.opt.spell = true --highlight spelling mistakes

-- Status Line
vim.opt.laststatus = 2 --0, 1, 2 or 3; when to use a status line for the last window
vim.opt.statusline = '%<%f %h%r%=%-14.(%l,%c %Y%) %P'

vim.opt.showmode = true -- display the current mode in the status line

-- Specify Register to be use when yanking. Leave '' for default
vim.opt.clipboard = '' --"unnamed" to use the * register like unnamed register
--"autoselect" to always put selected text on the clipboard

vim.opt.undolevels = 500 --maximum number of changes that can be undone

-- Tabs and Indentation
vim.opt.tabstop = 4       --number of spaces a <Tab> in the text stands for
vim.opt.shiftwidth = 4    --number of spaces used for each step of (auto)indent
vim.opt.smarttab = true   --a <Tab> in an indent inserts 'shiftwidth' spaces
vim.opt.expandtab = true  --expand <Tab> to spaces in Insert mode
vim.opt.autoindent = true --automatically set the indent of a new line

vim.opt.splitright = true

vim.cmd[[au TextYankPost * silent! lua vim.highlight.on_yank()]]

