local util = require 'util'

return {
  {
    'nvim-telescope/telescope.nvim',
    keys = { '<leader>e', '<leader>f', '<leader>d' },
    config = function()
      local actions = require 'telescope.actions'
      local action_layout = require 'telescope.actions.layout'
      require('telescope').setup {
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
      require('telescope').load_extension 'fzf'

      -- mappings
      local wk = require 'which-key'
      wk.add {
        { '<leader>e', group = 'telescope' },
        { '<leader>f', '<cmd>Telescope find_files<CR>', desc = 'find files' },
        {
          '<leader>ec',
          '<cmd>Telescope current_buffer_fuzzy_find<CR>',
          desc = 'find in current buffer',
        },
        { '<leader>d',   '<cmd>Telescope live_grep<CR>',   desc = 'find in cwd' },
        {
          '<leader>eu',
          '<cmd>Telescope grep_string<CR>',
          desc = 'find current word',
        },
        { '<leader>eg',  group = 'git & lsp' },
        { '<leader>egc', '<cmd>Telescope git_commits<CR>', desc = 'list commits' },
        {
          '<leader>egu',
          '<cmd>Telescope git_bcommits<CR>',
          desc = 'list current buffer commits',
        },
        {
          '<leader>egb',
          '<cmd>Telescope git_branches<CR>',
          desc = 'list branches',
        },
        { '<leader>egs', '<cmd>Telescope git_status<CR>', desc = 'show status' },
        { '<leader>egh', '<cmd>Telescope git_stash<CR>',  desc = 'list stashes' },
        -- { '<leader>el',  group = 'lsp' },
        {
          '<leader>egr',
          '<cmd>Telescope lsp_references<CR>',
          desc = 'list references',
        },
        {
          '<leader>egd',
          '<cmd>Telescope diagnostics bufnr=0<CR>',
          desc = 'list diagnostics',
        },
        { '<leader>em', '<cmd>Telescope keymaps<CR>', desc = 'list keymaps' },
        { '<leader>eb', '<cmd>Telescope buffers<CR>', desc = 'list buffers' },
      }
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
      },
    },
  },
}
