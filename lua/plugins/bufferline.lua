return function(use)
  use {
    'akinsho/bufferline.nvim',
    tag = 'v2.*',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require 'bufferline'.setup {
        options = {
---@diagnostic disable-next-line: assign-type-mismatch
          numbers = function(opts)
            return string.format('%s', opts.id)
          end,
          close_command = 'bdelete %d',
          max_name_length = 50,
          max_prefix_length = 30,
          offsets = { { filetype = 'NvimTree', text = 'File Explorer', text_align = 'left' } },
          show_buffer_close_icons = false,
          show_close_icon = false,
---@diagnostic disable-next-line: assign-type-mismatch
          diagnostics = 'nvim_lsp',
          diagnostics_indicator = function(_, level, _, _)
            local icon = level:match 'error' and '' or level:match 'warning' and '' or level:match 'info' and ''
                or level:match 'hint' and '' or '?'
            return icon
          end,
        },
      }

      -- mappings
      local map = require 'map'
      map.nmap(']]', '<cmd>BufferLineCycleNext<CR>')
      map.nmap('[[', '<cmd>BufferLineCyclePrev<CR>')
      map.nmap('<leader>y', '<cmd>BufferLineCycleNext<CR>')
      map.nmap('<leader>p', '<cmd>BufferLineCyclePrev<CR>')
      map.nmap('][', '<cmd>BufferLineMoveNext<CR>')
      map.nmap('[]', '<cmd>BufferLineMovePrev<CR>')
      map.nmap('<leader>bp', '<cmd>BufferLinePick<CR>')
      map.nmap('<leader>bc', '<cmd>BufferLinePickClose<CR>')
      map.nmap('<leader>bl', '<cmd>BufferLineCloseLeft<CR>')
      map.nmap('<leader>br', '<cmd>BufferLineCloseRight<CR>')
    end,
  }
end
