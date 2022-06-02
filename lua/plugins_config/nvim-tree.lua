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
  }
end
