return function(use)
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons', -- for file icon
    config = function()
      require 'nvim-tree'.setup {
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
        },
        git = {
          ignore = false,
        },
      }

      -- mapings
      local map = require 'map'
      map.nmap('<leader>n', '<cmd>NvimTreeToggle<CR>')
      map.nmap('<leader>r', '<cmd>NvimTreeRefresh<CR>')
    end,
  }
end
