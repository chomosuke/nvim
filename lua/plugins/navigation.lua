local util = require 'util'
return {
  {
    'smoka7/hop.nvim',
    lazy = false,
    version = '*',
    config = function()
      local hop = require 'hop'
      hop.setup { keys = "dtnfgcrlbmw',.py;qjkxaoeihus" }

      ---@diagnostic disable-next-line: missing-fields
      util.map('s', function() hop.hint_char2 {} end)
      ---@diagnostic disable-next-line: missing-fields
      util.map('S', function() hop.hint_lines_skip_whitespace {} end)
    end
  },

  {
    'ziontee113/syntax-tree-surfer',
    event = 'VeryLazy',
    config = function()
      require 'syntax-tree-surfer'

      local opts = { noremap = true, silent = true }

      -- Normal Mode Swapping:
      -- Swap The Master Node relative to the cursor with it's siblings, Dot Repeatable
      vim.keymap.set('n', ',tU', function()
        vim.opt.opfunc = 'v:lua.STSSwapUpNormal_Dot'
        return 'g@l'
      end, { silent = true, expr = true })
      vim.keymap.set('n', ',tD', function()
        vim.opt.opfunc = 'v:lua.STSSwapDownNormal_Dot'
        return 'g@l'
      end, { silent = true, expr = true })

      -- Swap Current Node at the ursor with it's siblings, Dot Repeatable
      vim.keymap.set('n', ',td', function()
        vim.opt.opfunc = 'v:lua.STSSwapCurrentNodeNextNormal_Dot'
        return 'g@l'
      end, { silent = true, expr = true })
      vim.keymap.set('n', ',tu', function()
        vim.opt.opfunc = 'v:lua.STSSwapCurrentNodePrevNormal_Dot'
        return 'g@l'
      end, { silent = true, expr = true })

      -- Visual Selection from Normal Mode
      vim.keymap.set('n', ',tx', '<cmd>STSSelectMasterNode<CR>', opts)
      vim.keymap.set('n', ',tn', '<cmd>STSSelectCurrentNode<CR>', opts)

      -- Select Nodes in Visual Mode
      vim.keymap.set('x', '<leader>j', '<cmd>STSSelectNextSiblingNode<CR>', opts)
      vim.keymap.set('x', '<leader>k', '<cmd>STSSelectPrevSiblingNode<CR>', opts)
      vim.keymap.set('x', '<leader>h', '<cmd>STSSelectParentNode<CR>', opts)
      vim.keymap.set('x', '<leader>l', '<cmd>STSSelectChildNode<CR>', opts)

      -- Swapping Nodes in Visual Mode
      vim.keymap.set('x', '<A-j>', '<cmd>STSSwapNextVisual<CR>', opts)
      vim.keymap.set('x', '<A-k>', '<cmd>STSSwapPrevVisual<CR>', opts)
    end,
  },
}
