local disable = true

if disable then
  return {
    "numToStr/Navigator.nvim",
    vim.keymap.set({ "n", "t" }, "<C-h>", "<CMD>NavigatorLeft<CR>"),
    vim.keymap.set({ "n", "t" }, "<C-l>", "<CMD>NavigatorRight<CR>"),
    vim.keymap.set({ "n", "t" }, "<C-k>", "<CMD>NavigatorUp<CR>"),
    vim.keymap.set({ "n", "t" }, "<C-j>", "<CMD>NavigatorDown<CR>"),
    vim.keymap.set({ "n", "t" }, "<C-p>", "<CMD>NavigatorPrevious<CR>"),
  }
end

return {

  "christoomey/vim-tmux-navigator",
  vim.keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>", { silent = true }),
  vim.keymap.set("n", "<C-j>", ":TmuxNavigateDown<CR>", { silent = true }),
  vim.keymap.set("n", "<C-k>", ":TmuxNavigateUp<CR>", { silent = true }),
  vim.keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>", { silent = true }),
}
