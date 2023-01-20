return {
  {
    'akinsho/toggleterm.nvim',
    keys = '<leader>t',
    config = function()
      require('toggleterm').setup {
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
      }
    end,
  },

  {
    'chomosuke/term-edit.nvim',
    ft = 'toggleterm',
    config = function()
      require('term-edit').setup {
        prompt_end = require('machine-specific').prompt_start,
        feedkeys_delay = 2,
        mapping = {
          n = {
            s = false,
            S = false,
          }
        }
      }
    end,
  },
}
