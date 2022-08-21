return function(use)
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require 'gitsigns'.setup {
        numhl = true,
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

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
          end, { expr = true })

          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, { expr = true })

          -- Actions
          map({ 'n', 'v' }, '<leader>gs', '<cmd>Gitsigns stage_hunk<CR>')
          map({ 'n', 'v' }, '<leader>gr', '<cmd>Gitsigns reset_hunk<CR>')
          map('n', '<leader>gS', '<cmd>Gitsigns stage_buffer<CR>')
          map('n', '<leader>gu', '<cmd>Gitsigns undo_stage_hunk<CR>')
          map('n', '<leader>gR', '<cmd>Gitsigns reset_buffer<CR>')
          map('n', '<leader>gp', '<cmd>Gitsigns preview_hunk<CR>')
          map('n', '<leader>gb', function() gs.blame_line { full = true } end)
          map('n', '<leader>gtb', '<cmd>Gitsigns toggle_current_line_blame<CR>')
          map('n', '<leader>gd', '<cmd>Gitsigns diffthis<CR>')
          map('n', '<leader>gD', function() gs.diffthis('~') end)
          map('n', '<leader>gtd', '<cmd>Gitsigns toggle_deleted<CR>')

          -- Text object
          map({ 'o', 'x' }, 'ih', '<cmd>Gitsigns select_hunk<CR>')
        end
      }
    end,
  }
  use 'tpope/vim-fugitive'
end
