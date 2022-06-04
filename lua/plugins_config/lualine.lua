return function()
  require 'lualine'.setup {
    options = {
      component_separators = '',
      section_separators = '',
      disabled_filetypes = { 'NvimTree', 'packer', 'dashboard' },
      always_divide_middle = false,
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'filetype' },
      lualine_c = { 'lsp_progress', 'diagnostics' },
      lualine_x = { 'diff' },
      lualine_y = { 'branch' },
      lualine_z = { 'progress' },
    },
    inactive_sections = {
      lualine_c = { 'filetype' },
      lualine_x = {},
    }
  }
end
