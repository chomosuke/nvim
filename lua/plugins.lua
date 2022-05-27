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

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require 'packer'.sync()
  end
end)
