return function()
  local actions = require "telescope.actions"
  local action_layout = require "telescope.actions.layout"
  require 'telescope'.setup {
    defaults = {
      file_ignore_patterns = {
        '^.git/',
        '^node_modules/',
      },
      mappings = {
        n = {
          [',.'] = actions.close,
          ['tp'] = action_layout.toggle_preview,
          ['tl'] = action_layout.cycle_layout_next,
        },
      },
      wrap_results = true,
      scroll_strategy = 'limit',
      dynamic_preview_title = true,
      layout_strategy = 'flex',
      layout_config = {
        flex = {
          flip_columns = 150,
        },
      },
    },
  }
end
