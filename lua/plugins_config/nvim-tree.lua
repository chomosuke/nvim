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
      show_on_dirs = true,
    },
  }
end
