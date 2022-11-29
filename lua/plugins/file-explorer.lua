return function(use)
  use {
    'nvim-tree/nvim-tree.lua',
    requires = 'nvim-tree/nvim-web-devicons', -- for file icon
    config = function()
      require('nvim-tree').setup {
        open_on_setup = true,
        view = {
          preserve_window_proportions = true,
        },
        renderer = {
          highlight_git = true,
          indent_markers = {
            enable = true,
          },
          icons = {
            show = {
              folder_arrow = false,
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
      }

      -- mapings
      local map = require 'map'
      map.nmap('<leader>n', '<cmd>NvimTreeToggle<CR>')
      map.nmap('<leader>r', '<cmd>NvimTreeRefresh<CR>')
    end,
  }
end
