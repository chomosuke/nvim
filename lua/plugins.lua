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

  -- prereq for many plugins
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- for git
  use {
    'lewis6991/gitsigns.nvim',
    config = require 'plugins_config.gitsigns',
  }
  use 'tpope/vim-fugitive'

  -- for language servers
  use 'williamboman/nvim-lsp-installer'
  use {
    'neovim/nvim-lspconfig',
    config = require 'plugins_config.nvim-lspconfig',
  }

  -- for rust
  use {
    'simrat39/rust-tools.nvim',
    config = require 'rust-tools'.setup {}
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
    'Mofiqul/vscode.nvim',
    config = function()
      vim.g.vscode_italic_comment = 1
      vim.g.vscode_disable_nvimtree_bg = true
--      vim.cmd [[
--        colorscheme vscode
--      ]]
    end,
  }
  use {
    'navarasu/onedark.nvim',
    config = function()
      require 'onedark'.load()
    end,
  }

  -- for file explorer
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- for file icon
    },
    config = require 'plugins_config.nvim-tree',
  }

  -- for smooth scrolling
  use {
    'karb94/neoscroll.nvim',
    config = function()
      require 'neoscroll'.setup()
    end,
  }

  -- for buffer as tabs
  use {
    'akinsho/bufferline.nvim',
    tag = 'v2.*',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require 'bufferline'.setup {
        options = {
          show_buffer_close_icons = false,
          show_close_icon = false,
        },
      }
    end,
  }

  -- for keybinding hint
  use {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup {}
    end
  }

  -- better escape mapping
  use {
    'max397574/better-escape.nvim',
    config = function()
      require 'better_escape'.setup {
        mapping = {',.'},
        timeout = 256,
      }
    end,
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require 'packer'.sync()
  end
end)
