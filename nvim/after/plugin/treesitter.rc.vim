if !exists('g:loaded_nvim_treesitter')
  finish
endif

lua <<EOF
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
    "html",
    "json",
    "scss",
    "css",
    "rust",
    "go",
    "javascript",
    "typescript",
    "c",
    "cpp",
    "python",
    "graphql",
  }
}
EOF
