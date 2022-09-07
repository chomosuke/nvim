return function(use)
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
    config = function()
      require 'nvim-treesitter.configs'.setup {
        -- ensure_installed = 'all',
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
