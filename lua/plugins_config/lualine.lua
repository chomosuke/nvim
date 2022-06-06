return function()
  local sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'filetype' },
    lualine_c = { 'lsp_progress', 'diagnostics' },
    lualine_x = { 'diff' },
    lualine_y = { 'branch' },
    lualine_z = { 'progress' },
  }
  require 'lualine'.setup {
    options = {
      component_separators = '',
      section_separators = '',
      disabled_filetypes = { 'dashboard' },
      always_divide_middle = false,
      globalstatus = true,
    },
    sections = sections,
    inactive_sections = sections,
  }
end
