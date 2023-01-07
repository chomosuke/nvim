return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = 'VeryLazy',
    build = function()
      require('nvim-treesitter.install').update { with_sync = true }
    end,
    dependencies = {
      -- bracket coloring
      'p00f/nvim-ts-rainbow',
    },
    config = function()
      require('nvim-treesitter.configs').setup {
        highlight = {
          enable = true,
        },
        rainbow = {
          enable = true,
        },
      }

      require('which-key').register {
        [',c'] = {
          function()
            vim.cmd [[
              TSDisable rainbow
              TSDisable highlight
              TSEnable rainbow
              TSEnable highlight
            ]]
          end,
          'Refresh treesitter',
        },
      }
    end,
  },
}
