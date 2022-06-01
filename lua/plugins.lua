-- for bootstrap
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
end

-- for auto PackerSync
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

return require 'packer'.startup(function(use)
  -- for packer to host itself
  use 'wbthomason/packer.nvim'

  -- for git
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require 'gitsigns'.setup {
        signcolumn = false,
        numhl = true,
      }
    end,
  }
  use 'tpope/vim-fugitive'

  -- for language servers
  use 'williamboman/nvim-lsp-installer'
  use {
    'neovim/nvim-lspconfig',
    config = function()
      require 'nvim-lsp-installer'.setup {
        automatic_installation = true,
      }
      local lspconfig = require 'lspconfig'
      lspconfig.rust_analyzer.setup {
        settings = {
          ['rust-analyzer'] = {
            checkOnSave = {
              command = 'clippy',
            },
          },
        },
      }
      lspconfig.sumneko_lua.setup {}
      lspconfig.hls.setup {}
    end,
  }

  -- for rust
  use {
    'simrat39/rust-tools.nvim',
    config = function()
      require 'rust-tools'.setup {}
    end,
  }

  -- for indentation
  use {
    'nmac427/guess-indent.nvim',
    config = function()
      require 'guess-indent'.setup {}
    end,
  }

  -- for telescope finding files
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use {
    'nvim-telescope/telescope.nvim',
    defaults = {
      file_ignore_patterns = {
        '^.git/',
        '^node_modules/',
      },
    },
    requires = 'nvim-lua/plenary.nvim',
  }

  -- for status line
  use {
    'feline-nvim/feline.nvim',
    config = function()
      require 'feline'.setup()
    end,
  }

  -- for indentation guides
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require 'indent_blankline'.setup {}
    end,
  }

  -- for theme
  use {
    'joshdick/onedark.vim',
    config = function()
      vim.cmd [[
        syntax on
        colorscheme onedark
      ]]
    end,
  }

  -- for file explorer
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- for file icon
    },
    config = function()
      require 'nvim-tree'.setup {
        git = {
          ignore = false,
        },
        renderer = {
          highlight_git = true,
          highlight_opened_files = 'icon',
          indent_markers = {
            enable = true,
          },
        },
      }
    end,
  }

  -- for smooth scrolling
  use {
    'karb94/neoscroll.nvim',
    config = function()
      require 'neoscroll'.setup()
    end,
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require 'packer'.sync()
  end
end)
