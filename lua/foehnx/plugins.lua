local use = require('packer').use
require('packer').startup(
  function()
    use 'wbthomason/packer.nvim'

    -- LSP and autocomplete
    -----------------------
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'saadparwaiz1/cmp_luasnip'
    use 'L3MON4D3/LuaSnip'
    use 'onsails/lspkind-nvim'
    --use 'ray-x/lsp_signature.nvim'
    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
    }
    
    -- Telescope
    ------------
    use {
      'nvim-telescope/telescope.nvim',
      requires = { {'nvim-lua/plenary.nvim'} },
    }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    -- Status Line
    --------------
    use 'nvim-lualine/lualine.nvim'
    use 'arkav/lualine-lsp-progress'

    -- Buffers and Tabs
    -------------------
    use 'akinsho/bufferline.nvim'
    use 'kazhala/close-buffers.nvim'

    -- Theme
    --------
    -- use 'marko-cerovac/material.nvim'
    use {'kaicataldo/material.vim', branch='main'}
    use 'nvim-lua/popup.nvim'

    -- Tree
    -------
    use {
      'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons', -- optional, for file icon
      },
      config = function() require'nvim-tree'.setup {} end
    }

    -- Git
    ------
    use 'f-person/git-blame.nvim'

    -- Terminal
    -----------
    use 'akinsho/toggleterm.nvim'

    -- Mini toolkit
    ---------------
    use { 'echasnovski/mini.nvim' }

    -- Which Key
    ------------
    use 'folke/which-key.nvim'
  end
)
