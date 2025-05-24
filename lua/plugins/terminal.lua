local util = require 'util'
return {
  {
    'akinsho/toggleterm.nvim',
    keys = '<leader>t',
    opts = {
      size = function(_)
        if vim.o.lines > 48 then
          return vim.o.lines / 4
        else
          return 12
        end
      end,
      open_mapping = '<leader>t',
      start_in_insert = false,
      insert_mappings = false,
      terminal_mappings = false,
      persist_size = false,
      on_create = function(term)
        -- TermInit can be set in .nvim.lua so that project specific command can be ran upon terminal start
        -- Example config
        -- _G.TermInit = function(term)
        --   term:send('conda activate', false)
        -- end
        ---@diagnostic disable-next-line: undefined-field
        if _G.TermInit ~= nil then
          ---@diagnostic disable-next-line: undefined-field
          _G.TermInit(term)
        end
      end,
    },
  },

  {
    'chomosuke/term-edit.nvim',
    -- dev = true,
    version = '1.*',
    event = 'TermOpen',
    opts = {
      prompt_end = require('machine-config').prompt_end,
      feedkeys_delay = util.is_windows() and 100 or 20,
      mapping = {
        n = {
          ['<C-i>'] = 'o',
          s = false,
          S = false,
        },
      },
      default_reg = '+',
    },
  },
}
