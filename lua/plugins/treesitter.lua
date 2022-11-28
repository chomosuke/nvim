return function(use)
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      require 'nvim-treesitter.install'.update({ with_sync = true })
    end,
    config = function()
      require 'nvim-treesitter.configs'.setup {
        highlight = {
          enable = true,
        },
        rainbow = {
          enable = true,
        },
      }

      require 'which-key'.register {
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
  }
  -- bracket coloring
  use 'p00f/nvim-ts-rainbow'
end
