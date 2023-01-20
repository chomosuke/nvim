return {
  {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'arkav/lualine-lsp-progress',
    },
    config = function()
      local sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'filetype' },
        lualine_c = { 'lsp_progress', 'diagnostics' },
        lualine_x = { 'diff', 'branch' },
        lualine_y = {
          function()
            local ff = vim.bo.fileformat
            local r
            if ff == 'unix' then
              r = 'LF'
            elseif ff == 'dos' then
              r = 'CRLF'
            end
            local eol = vim.bo.endofline
            if not eol then
              r = r .. ' NOEOL'
            end
            return r
          end,
        },
        lualine_z = { '%c/%{strwidth(getline("."))}:%L' },
      }
      require('lualine').setup {
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
        },
      }
    end,
  },
}
