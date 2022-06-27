return function()
  local sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'filetype' },
    lualine_c = { 'lsp_progress', 'diagnostics' },
    lualine_x = { 'diff', 'branch' },
    lualine_y = {
      {
        'fileformat',
        icons_enabled = false,
        fmt = function(ff)
          if ff == 'unix' then
            ff = 'LF'
          elseif ff == 'dos' then
            ff = 'CRLF'
          end
          return ff
        end,
      },
    },
    lualine_z = { '%{strwidth(getline("."))}:%L' },
  }
  require 'lualine'.setup {
    options = {
      component_separators = '',
      section_separators = '',
      disabled_filetypes = { 'NvimTree', 'packer' },
      always_divide_middle = false,
      -- globalstatus = true,
    },
    sections = sections,
    inactive_sections = {
      lualine_c = { 'filetype' },
      lualine_x = {},
    }
  }
end
