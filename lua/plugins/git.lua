return {
  {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    config = function()
      require('gitsigns').setup {
        numhl = true,
        current_line_blame_opts = {
          delay = 0,
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local wk = require 'which-key'

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            opts.noremap = true
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then
              return ']c'
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return '<Ignore>'
          end, {
            expr = true,
            desc = 'next hunk',
          })

          map('n', '[c', function()
            if vim.wo.diff then
              return '[c'
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return '<Ignore>'
          end, {
            expr = true,
            desc = 'prev hunk',
          })

          -- Actions
          wk.register({
            ['<leader>g'] = {
              name = 'git',
              s = { '<cmd>Gitsigns stage_hunk<CR>', 'stage hunk' },
              r = { '<cmd>Gitsigns reset_hunk<CR>', 'reset hunk' },
            },
          }, { buffer = bufnr })
          wk.register({
            ['<leader>g'] = {
              name = 'git',
              s = { ":'<,'>Gitsigns stage_hunk<CR>", 'stage hunk' },
              r = { ":'<,'>Gitsigns reset_hunk<CR>", 'reset hunk' },
            },
          }, { mode = 'v', buffer = bufnr })
          wk.register({
            ['<leader>g'] = {
              name = 'git',
              S = { gs.stage_buffer, 'stage buffer' },
              u = { gs.undo_stage_hunk, 'undo stage hunk' },
              R = { gs.reset_buffer, 'reset buffer' },
              p = { gs.preview_hunk, 'preview hunk' },
              b = {
                function()
                  gs.blame_line { full = true }
                end,
                'blame line',
              },
              t = {
                name = 'toggle',
                b = { gs.toggle_current_line_blame, 'current line blame' },
                d = { gs.toggle_deleted, 'deleted' },
              },
              d = { gs.diffthis, 'diff this' },
              D = {
                function()
                  gs.diffthis '~'
                end,
                'diff this',
              },
            },
          }, {
            buffer = bufnr,
          })

          -- Text object
          local text_object_mappings = {
            ih = { '<cmd><C-U>Gitsigns select_hunk<CR>', 'select hunk' },
          }
          wk.register(text_object_mappings, { buffer = bufnr, mode = 'o' })
          wk.register(text_object_mappings, { buffer = bufnr, mode = 'x' })
        end,
      }
    end,
  },

  {
    'tpope/vim-fugitive',
    event = 'VeryLazy',
  },

  {
    'akinsho/git-conflict.nvim',
    event = 'VeryLazy',
    config = function()
      require('git-conflict').setup {
        default_mappings = false,
        disable_diagnostics = true,
      }
    end,
  },
}
