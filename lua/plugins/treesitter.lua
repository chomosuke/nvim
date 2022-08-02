return function(use)
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require 'nvim-treesitter.install'.compilers = { 'clang' }
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = 'all',
        highlight = {
          enable = true,
        },
        rainbow = {
          enable = true,
        },
      }
    end,
  }
  -- bracket coloring
  use 'p00f/nvim-ts-rainbow'
end
