return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'arkav/lualine-lsp-progress',
    },
    config = function()
      local colors = require 'onedark.colors'
      local ft_termnum = {
        'filetype',
        fmt = function(str)
          ---@diagnostic disable-next-line: undefined-field
          if vim.b.toggle_number ~= nil then
            ---@diagnostic disable-next-line: undefined-field
            str = 'term[' .. vim.b.toggle_number .. ']'
          end
          return str
        end,
      }
      local sections = {
        lualine_a = { 'mode' },
        lualine_b = { ft_termnum },
        lualine_c = {
          {
            'lsp_progress',
            colors = {
              percentage = colors.cyan,
              title = colors.cyan,
              message = colors.cyan,
              spinner = colors.cyan,
              lsp_client_name = colors.magenta,
              use = true,
            },
            separators = {
              component = ' ',
              progress = ' | ',
              percentage = { pre = '', post = '%% ' },
              title = { pre = '', post = ': ' },
              lsp_client_name = { pre = '[', post = ']' },
              spinner = { pre = '', post = '' },
              message = {
                pre = '(',
                post = ')',
                commenced = 'In Progress',
                completed = 'Completed',
              },
            },
            display_components = {
              'lsp_client_name',
              'spinner',
              { 'title', 'percentage', 'message' },
            },
            timer = {
              progress_enddelay = 500,
              spinner = 1000,
              lsp_client_name_enddelay = 1000,
            },
            spinner_symbols = {
              '🌑 ',
              '🌒 ',
              '🌓 ',
              '🌔 ',
              '🌕 ',
              '🌖 ',
              '🌗 ',
              '🌘 ',
            },
          },
          'diagnostics',
        },
        lualine_x = {
          'diff',
          'branch',
        },
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
          lualine_c = { ft_termnum },
        },
      }
    end,
  },
}
