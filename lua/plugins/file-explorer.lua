return {
  {
    'nvim-tree/nvim-tree.lua',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- for file icon
    config = function()
      require('nvim-tree').setup {
        open_on_setup = true,
        view = {
          mappings = {
            list = {
              { key = 'r', action = 'full_rename' },
            },
          },
        },
        renderer = {
          highlight_opened_files = 'icon',
          full_name = true,
          indent_markers = {
            enable = true,
          },
          icons = {
            show = {
              folder_arrow = false,
            },
            glyphs = {
              modified = '[+]',
            },
          },
        },
        diagnostics = {
          enable = true,
          icons = {
            hint = '',
            info = '',
            warning = '',
            error = '',
          },
          show_on_dirs = true,
          show_on_open_dirs = false,
        },
        git = {
          ignore = false,
          show_on_dirs = true,
          show_on_open_dirs = false,
        },
        modified = {
          enable = true,
          show_on_dirs = true,
          show_on_open_dirs = false,
        },
      }

      -- mapings
      local map = require 'map'
      map.nmap('<leader>n', '<cmd>NvimTreeToggle<CR>')
      map.nmap('<leader>r', '<cmd>NvimTreeRefresh<CR>')
    end,
  },
}
