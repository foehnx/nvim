-- Neovide
vim.g['neovide_fullscreen']= true
vim.opt.guifont="MesloLGS NF:h9"

-- Theme
-- vim.g.material_style = 'deep ocean'
vim.g.material_theme_style = 'ocean'
vim.cmd 'colorscheme material'

-- System
vim.g.mapleader= ' '
vim.opt.mouse="a"
vim.opt.ttyfast = true
vim.opt.secure = true
vim.opt.hidden = true
vim.opt.undofile = true
vim.opt.showmode = false
vim.opt.swapfile = false

-- Visuals
vim.opt.syntax = "disable"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autoindent = true
vim.opt.smartindent = false
vim.opt.cindent = false
vim.opt.scrolloff=5
vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- Convenience
vim.opt.tabstop=2
vim.opt.shiftwidth=2
vim.opt.softtabstop=2
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.backspace='indent,eol,start'
vim.opt.switchbuf='useopen'
vim.opt.laststatus=2
vim.opt.splitbelow = true
vim.opt.splitright = true

-- For coding convenience
vim.opt.cmdheight=1
vim.opt.updatetime=100
vim.opt.colorcolumn='101'
vim.opt.signcolumn = "auto:2"

