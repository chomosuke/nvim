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
      -- xml autotag
      'windwp/nvim-ts-autotag',
      -- debounce refresh
      'runiq/neovim-throttle-debounce',
    },
    config = function()
      require('nvim-treesitter.configs').setup {
        highlight = {
          enable = true,
        },
        rainbow = {
          enable = true,
        },
        autotag = {
          enable = true,
        },
      }
      local function refresh()
        vim.cmd [[
          TSDisable rainbow
          TSDisable highlight
          TSEnable rainbow
          TSEnable highlight
        ]]
      end
      local function refresh_rainbow()
        vim.cmd [[
          TSDisable rainbow
          TSEnable rainbow
        ]]
      end
      require('util').create_autocmds('refresh_treesitter', {
        {
          event = 'BufWrite',
          opts = {
            callback = refresh_rainbow,
          },
        },
      })
      require('which-key').register {
        [',c'] = {
          refresh,
          'Refresh treesitter',
        },
      }
    end,
  },
}
