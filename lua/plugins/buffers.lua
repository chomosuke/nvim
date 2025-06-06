return {
  {
    'akinsho/bufferline.nvim',
    lazy = false,
    version = '4.*',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('bufferline').setup {
        options = {
          ---@diagnostic disable-next-line: assign-type-mismatch
          numbers = function(opts)
            return string.format('%s', opts.id)
          end,
          close_command = 'bdelete %d',
          max_name_length = 50,
          max_prefix_length = 30,
          offsets = {
            {
              filetype = 'NvimTree',
              text = 'File Explorer',
              text_align = 'left',
            },
          },
          show_buffer_close_icons = false,
          show_close_icon = false,
          ---@diagnostic disable-next-line: assign-type-mismatch
          diagnostics = 'nvim_lsp',
          diagnostics_indicator = function(_, level, _, _)
            local icon = level:match 'error' and '󰅚'
                or level:match 'warning' and '󰀪'
                or level:match 'info' and '󰋽'
                or level:match 'hint' and '󰌶'
                or '?'
            return icon
          end,
          sort_by = 'insert_after_current',
        },
      }

      -- mappings
      local util = require 'util'
      util.nmap(']]', '<cmd>BufferLineCycleNext<CR>')
      util.nmap('[[', '<cmd>BufferLineCyclePrev<CR>')
      util.nmap('][', '<cmd>BufferLineMoveNext<CR>')
      util.nmap('[]', '<cmd>BufferLineMovePrev<CR>')
      local wk = require 'which-key'

      wk.add {
        { '<leader>b',  group = 'buffer' },
        { '<leader>bn', '<cmd>BufferLineCycleNext<CR>',  desc = 'cycle next' },
        { '<leader>bp', '<cmd>BufferLineCyclePrev<CR>',  desc = 'cycle prev' },
        -- { '<leader>bp', '<cmd>BufferLinePick<CR>', desc = 'pick' },
        { '<leader>bd', '<cmd>BufferLinePickClose<CR>',  desc = 'close' },
        { '<leader>bl', '<cmd>BufferLineCloseLeft<CR>',  desc = 'close left' },
        { '<leader>br', '<cmd>BufferLineCloseRight<CR>', desc = 'close right' },
      }
    end,
  },
  {
    'chrisgrieser/nvim-early-retirement',
    opts = {
      minimumBufferNum = 3,
    },
    event = 'VeryLazy',
  },
}
