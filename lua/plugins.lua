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
    end
  }

  -- for language servers
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/lsp-status.nvim'
  use 'nvim-lua/completion-nvim'
end)
