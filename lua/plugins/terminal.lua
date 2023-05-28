local util = require 'util'
return {
  {
    'akinsho/toggleterm.nvim',
    keys = '<leader>t',
    opts = {
      size = 12,
      open_mapping = '<leader>t',
      start_in_insert = false,
      insert_mappings = false,
      terminal_mappings = false,
      persist_size = false,
      on_create = function(term)
        term:send("export GIT_EDITOR='nvd --nofork --size=800x500'", false)
        term:clear()
      end,
    },
  },

  {
    'chomosuke/term-edit.nvim',
    version = '1.*',
    ft = 'toggleterm',
    dev = true,
    opts = {
      prompt_end = require('machine-config').prompt_end,
      feedkeys_delay = util.is_windows() and 100 or 2,
      mapping = {
        n = {
          s = false,
          S = false,
        },
      },
    },
  },
}
