vim.g.mapleader = " "

-- Windows Management
vim.keymap.set("n", "wr", "<C-w>v", { desc = "Split to the Right" })
vim.keymap.set("n", "wb", "<C-w>s", { desc = "Split to the Bottom" })
vim.keymap.set("n", "wq", ":close<CR>", { desc = "Close current tab" })
vim.keymap.set("n", "wu", ":bp<CR>", { desc = "Close current tab" })
-- Window Movement
vim.keymap.set("n", "wh", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "wl", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "wj", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "wk", "<C-w><C-k>", { desc = "Move focus to the upper window" })
-- Line Management
vim.keymap.set("n", "<S-CR>", "A<CR><ESC>", { desc = "Create a new Line" })
vim.keymap.set("n", "<C-CR>", "i<CR><ESC>", { desc = "Create a new Line since cursor position" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Line one line to bottom" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Line one line to top" })
-- Movement Centered
vim.keymap.set("n", "n", "nzzzv", { desc = "Next Ocurrence in Middle Screen" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous Ocurrence in Middle Screen" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll Down Keeping Cursor in the Middle" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll Up Keeping Cursor in the Middle" })
-- Yanks
vim.keymap.set({ "v", "n" }, "Y", "y$")
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]])
-- Teminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Close Terminal" })
vim.keymap.set("n", "<leader>t", "<cmd>bel term<CR>")
vim.keymap.set("n", "<leader>tw", function()
    local bufferFilePath = vim.fn.expand("%")
    local bufferDirectory = vim.fn.fnamemodify(bufferFilePath, ":p:h")
    vim.cmd(string.format(":botright new | call termopen(&shell, #{cwd: '%s'})", bufferDirectory))
end)
