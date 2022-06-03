return function()
  vim.g.dashboard_default_executive = 'telescope'
  vim.g.indent_blankline_filetype_exclude = {
    'dashboard',
    'lspinfo',
    'packer',
    'checkhealth',
    'help',
    'man',
    '',
  }
  vim.g.dashboard_custom_shortcut = {
    last_session = 'SPC d l',
    find_history = 'SPC d h',
    find_file = 'SPC f f',
    new_file = 'SPC d n',
    change_colorscheme = 'SPC d c',
    find_word = 'SPC f d',
    book_marks = 'SPC d b',
  }
  vim.g.dashboard_custom_header = {
    ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
    ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
    ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
    ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
    ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
    ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
  }
  vim.g.dashboard_custom_footer = {''}
end
