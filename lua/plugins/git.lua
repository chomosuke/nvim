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
          map('n', 'gj', function()
            if vim.wo.diff then
              return 'gj'
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return '<Ignore>'
          end, {
            expr = true,
            desc = 'next hunk',
          })

          map('n', 'gk', function()
            if vim.wo.diff then
              return 'gk'
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
          wk.add {
            buffer = bufnr,
            { '<leader>g', group = 'git' },
            {
              '<leader>gs',
              '<cmd>Gitsigns stage_hunk<CR>',
              desc = 'stage hunk',
            },
            {
              '<leader>gr',
              '<cmd>Gitsigns reset_hunk<CR>',
              desc = 'reset hunk',
            },
            { '<leader>gS', gs.stage_buffer, desc = 'stage buffer' },
            { '<leader>gu', gs.undo_stage_hunk, desc = 'undo stage hunk' },
            { '<leader>gR', gs.reset_buffer, desc = 'reset buffer' },
            { '<leader>gp', gs.preview_hunk, desc = 'preview hunk' },
            {
              '<leader>gb',
              function()
                gs.blame_line { full = true }
              end,
              desc = 'blame line',
            },
            { '<leader>gt', group = 'toggle' },
            {
              '<leader>gtb',
              gs.toggle_current_line_blame,
              desc = 'current line blame',
            },
            { '<leader>gtd', gs.toggle_deleted, desc = 'deleted' },
            { '<leader>gd', gs.diffthis, desc = 'diff this' },
            {
              '<leader>gD',
              function()
                gs.diffthis '~'
              end,
              desc = 'diff this',
            },

            {
              mode = 'v',
              {
                '<leader>gs',
                ":'<,'>Gitsigns stage_hunk<CR>",
                desc = 'stage hunk',
              },
              {
                '<leader>gr',
                ":'<,'>Gitsigns reset_hunk<CR>",
                desc = 'reset hunk',
              },
            },

            -- Text object
            {
              'ih',
              '<cmd><C-U>Gitsigns select_hunk<CR>',
              desc = 'select hunk',
              mode = { 'o', 'x' },
            },
          }
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
