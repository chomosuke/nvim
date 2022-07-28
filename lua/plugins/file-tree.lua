return function(use)
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons', -- for file icon
    config = function()
      require 'nvim-tree'.setup {
        view = {
          adaptive_size = true,
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
      map.nmap('<Leader>n', '<cmd>NvimTreeToggle<CR>')
      map.nmap('<Leader>r', '<cmd>NvimTreeRefresh<CR>')
    end,
  }
end