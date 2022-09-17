-- get rid of auto linewrap in git commit
require 'util'.create_autocmds(
  'git_commit_no_tw',
  { { 'FileType', { command = 'setlocal tw=0', pattern = 'gitcommit' } } }
)

return function(use)
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require 'gitsigns'.setup {
        numhl = true,
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
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, {
            expr = true,
            desc = 'next hunk',
          })

          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, {
            expr = true,
            desc = 'prev hunk',
          })

          -- Actions
          local nv_actions_mappings = {
            ['<leader>g'] = {
              name = 'git',
              s = { ':Gitsigns stage_hunk<CR>', 'stage hunk' },
              r = { ':Gitsigns reset_hunk<CR>', 'reset hunk' },
            },
          }
          wk.register(nv_actions_mappings, { buffer = bufnr })
          wk.register(nv_actions_mappings, { mode = 'v', buffer = bufnr })
          wk.register({
            ['<leader>g'] = {
              name = 'git',
              S = { gs.stage_buffer, 'stage buffer' },
              u = { gs.undo_stage_hunk, 'undo stage hunk' },
              R = { gs.reset_buffer, 'reset buffer' },
              p = { gs.preview_hunk, 'preview hunk' },
              b = { function() gs.blame_line { full = true } end, 'blame line' },
              t = {
                name = 'toggle',
                b = { gs.toggle_current_line_blame, 'current line blame' },
                d = { gs.toggle_deleted, 'deleted' },
              },
              d = { gs.diffthis, 'diff this' },
              D = { function() gs.diffthis('~') end, 'diff this' },
            },
          }, {
            buffer = bufnr,
          })

          -- Text object
          local text_object_mappings = {
            ih = { ':<C-U>Gitsigns select_hunk<CR>', 'select hunk' }
          }
          wk.register(text_object_mappings, { buffer = bufnr, mode = 'o' })
          wk.register(text_object_mappings, { buffer = bufnr, mode = 'x' })
        end
      }
    end,
  }

  use 'tpope/vim-fugitive'

  use {
    'akinsho/git-conflict.nvim',
    tag = '*',
    config = function()
      require 'git-conflict'.setup {
        default_mappings = false,
      }
    end,
  }
end
