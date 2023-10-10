return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = 'VeryLazy',
    build = function()
      require('nvim-treesitter.install').update { with_sync = true }
    end,
    config = function()
      require('nvim-treesitter.configs').setup {
        highlight = {
          enable = true,
        },
      }
    end,
  },

  {
    'hiphish/rainbow-delimiters.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      local rainbow_delimiters = require 'rainbow-delimiters'
      require 'rainbow-delimiters.setup' {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          -- latex = 'rainbow-blocks',
          -- lua = 'rainbow-blocks',
        },
        highlight = {
          'TSRainbowRed',
          'TSRainbowYellow',
          'TSRainbowBlue',
          'TSRainbowOrange',
          'TSRainbowGreen',
          'TSRainbowViolet',
          'TSRainbowCyan',
        },
      }
    end,
  },
}
