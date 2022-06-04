return function()
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
      map({ 'n', 'v' }, '<Leader>gs', ':Gitsigns stage_hunk<CR>')
      map({ 'n', 'v' }, '<Leader>gr', ':Gitsigns reset_hunk<CR>')
      map('n', '<Leader>gS', ':Gitsigns stage_buffer<CR>')
      map('n', '<Leader>gu', ':Gitsigns undo_stage_hunk<CR>')
      map('n', '<Leader>gR', ':Gitsigns reset_buffer<CR>')
      map('n', '<Leader>gp', ':Gitsigns preview_hunk<CR>')
      map('n', '<Leader>gb', function() gs.blame_line { full = true } end)
      map('n', '<Leader>gtb', ':Gitsigns toggle_current_line_blame<CR>')
      map('n', '<Leader>gd', ':Gitsigns diffthis<CR>')
      map('n', '<Leader>gD', function() gs.diffthis('~') end)
      map('n', '<Leader>gtd', ':Gitsigns toggle_deleted<CR>')

      -- Text object
      map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
  }
end
