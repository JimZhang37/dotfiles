return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            -- Point this EXACTLY to your GCC path from the JSON
            -- "--query-driver=/usr/local/bin/g++-15",
            "--all-scopes-completion",
            "--completion-style=detailed",
            -- This tells clangd to respect the .clangd file we just made
            "--enable-config",
          },
        },
      },
    },
  },
}
