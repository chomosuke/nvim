return function()
  require 'nvim-tree'.setup {
    git = {
      ignore = false,
    },
    renderer = {
      highlight_git = true,
      highlight_opened_files = 'icon',
      indent_markers = {
        enable = true,
      },
    },
    diagnostics = {
      enable = true,
      icons = {
        hint = '',
        info = '',
        warning = '',
        error = '',
      }, show_on_dirs = true,
    },
  }

  -- mapings
  local map = require 'map'
  map.nmap('<Leader>n', '<cmd>NvimTreeToggle<CR>')
  map.nmap('<Leader>r', '<cmd>NvimTreeRefresh<CR>')
end
