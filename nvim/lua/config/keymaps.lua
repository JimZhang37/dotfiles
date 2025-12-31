-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- ~/.config/nvim/lua/config/keymaps.lua

-- vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
-- vim.keymap.set("n", "<c-i>", ":wincmd i<CR>")
-- vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
-- vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

-- ~/.config/nvim/lua/config/keymaps.lua

vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true })
