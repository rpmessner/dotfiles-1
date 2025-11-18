return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      -- python = {
      --   -- Force Pyright to use your asdf Python
      --   pythonPath = "/Users/ryanmessner/.asdf/shims/python",
      --   analysis = {
      --     -- Add your site-packages path explicitly
      --     extraPaths = {
      --       "/Users/ryanmessner/.asdf/installs/python/3.14.0/lib/python3.14/site-packages",
      --     },
      --   },
      -- },
      clangd = {
        cmd = {
          "clangd",
          "--compile-commands-dir=build", -- Or use symlink
          "--background-index",
          "--clang-tidy",
          "--completion-style=detailed",
          "--header-insertion=iwyu",
        },
      },
    },
  },
}
