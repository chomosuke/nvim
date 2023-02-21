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
      require('util').create_autocmds(
        'refresh_treesitter',
        { { event = 'InsertLeave', opts = { callback = refresh } } }
      )
    end,
  },
}
