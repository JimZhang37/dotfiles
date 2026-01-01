return {
  "https://codeberg.org/esensar/nvim-dev-container",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("devcontainer").setup({
      -- This ensures that when the container starts,
      -- it uses your local nvim config
      attach_mounts = {
        neovim_config = {
          enabled = true,
          type = "bind",
        },
      },
    })
  end,
}
