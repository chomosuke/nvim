return function()
  local actions = require 'telescope.actions'
  local action_layout = require 'telescope.actions.layout'
  require 'telescope'.setup {
    defaults = {
      file_ignore_patterns = {
        '%.git/',
        '%.git\\',
        'node_modules/',
        'node_modules\\',
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
  require 'telescope'.load_extension 'fzf'

  -- mappings
  local map = require 'map'
  map.nmap(';f', '<cmd>Telescope find_files<CR>')
  map.nmap(';c', '<cmd>Telescope current_buffer_fuzzy_find<CR>')
  map.nmap(';d', '<cmd>Telescope live_grep<CR>')
  map.nmap(';u', '<cmd>Telescope grep_string<CR>')
  map.nmap(';gc', '<cmd>Telescope git_commits<CR>')
  map.nmap(';gu', '<cmd>Telescope git_bcommits<CR>')
  map.nmap(';gb', '<cmd>Telescope git_branches<CR>')
  map.nmap(';gs', '<cmd>Telescope git_status<CR>')
  map.nmap(';gh', '<cmd>Telescope git_stash<CR>')
  map.nmap(';lr', '<cmd>Telescope lsp_references<CR>')
  map.nmap(';ld', '<cmd>Telescope diagnostics bufnr=0<CR>')
  map.nmap(';vm', '<cmd>Telescope keymaps<CR>')
  map.nmap(';b', '<cmd>Telescope buffers<CR>')
  -- map <Leader>; back to ; for actual ; usage
  map.nmap('<Leader>;', ';')
end
