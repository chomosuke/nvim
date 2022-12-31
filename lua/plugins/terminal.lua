return function(use)
  use {
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup {
        size = 12,
        open_mapping = '<leader>t',
        start_in_insert = false,
        insert_mappings = false,
        terminal_mappings = false,
        persist_size = false,
        on_create = function(term)
          term:send("export GIT_EDITOR='nvd --nofork'", false)
          term:clear()
        end,
      }
    end,
  }
end
