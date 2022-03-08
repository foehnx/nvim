require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'bash',
    'make',
    'cmake',
    'c',
    'cpp',
    'cuda',
    'llvm',
    'yaml',
    'json',
    'python',
    'lua',
    'html',
    'latex',
    'bibtex',
  },
  highlight = {
    enable = true,
    disable = {},
  }
})

