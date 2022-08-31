require 'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = false,
    disable = {},
  },
  ensure_installed = {
    "go",
    "rust",
    "python",
    "javascript",
    "typescript",
    "tsx"
  }
}
