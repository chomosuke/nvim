return {
  {
    'nvim-telescope/telescope.nvim',
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
      wk.register {
        ['<leader>f'] = {
          name = 'telescope',
          f = { '<cmd>Telescope find_files<CR>', 'find files' },
          c = {
            '<cmd>Telescope current_buffer_fuzzy_find<CR>',
            'find in current buffer',
          },
          d = { '<cmd>Telescope live_grep<CR>', 'find in cwd' },
          u = { '<cmd>Telescope grep_string<CR>', 'find current word' },
          g = {
            name = 'git',
            c = { '<cmd>Telescope git_commits<CR>', 'list commits' },
            u = {
              '<cmd>Telescope git_bcommits<CR>',
              'list current buffer commits',
            },
            b = { '<cmd>Telescope git_branches<CR>', 'list branches' },
            s = { '<cmd>Telescope git_status<CR>', 'show status' },
            h = { '<cmd>Telescope git_stash<CR>', 'list stashes' },
          },
          l = {
            name = 'lsp',
            r = { '<cmd>Telescope lsp_references<CR>', 'list references' },
            d = { '<cmd>Telescope diagnostics bufnr=0<CR>', 'list diagnostics' },
          },
          m = { '<cmd>Telescope keymaps<CR>', 'list keymaps' },
          b = { '<cmd>Telescope buffers<CR>', 'list buffers' },
        },
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
