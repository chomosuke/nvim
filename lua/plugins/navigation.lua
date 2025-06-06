return {
  {
    'ggandor/leap.nvim',
    lazy = false, -- Lazy loading won't work
    config = function()
      require('leap').setup {
        equivalence_classes = {
          {
            ' \t\r\n',
            ')]}>',
            '([{<',
            { '"', "'", '`' },
          },
        },
        safe_labels = {},
        -- stylua: ignore
        labels = {
          'e', 'u', 'o', 'a', 'i', 't', 'h', 'n', 's', 'd', '.', 'p', ';', 'y',
          'c', 'g', 'r', 'z', 'f', 'k', 'q', 'j', 'x', 'm', 'v', 'w', 'b', "'",
          'l', 'E', 'U', 'O', 'A', 'I', 'T', 'H', 'N', 'S', 'D', '>', 'P', ':',
          'Y', 'C', 'G', 'R', 'Z', 'F', 'K', 'Q', 'J', 'X', 'M', 'V', 'W', 'B',
          '"', 'L',
        },
      }
      require('leap').set_default_keymaps()
    end,
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
      vim.keymap.set('x', 'J', '<cmd>STSSelectNextSiblingNode<CR>', opts)
      vim.keymap.set('x', 'K', '<cmd>STSSelectPrevSiblingNode<CR>', opts)
      vim.keymap.set('x', 'H', '<cmd>STSSelectParentNode<CR>', opts)
      vim.keymap.set('x', 'L', '<cmd>STSSelectChildNode<CR>', opts)

      -- Swapping Nodes in Visual Mode
      vim.keymap.set('x', '<A-j>', '<cmd>STSSwapNextVisual<CR>', opts)
      vim.keymap.set('x', '<A-k>', '<cmd>STSSwapPrevVisual<CR>', opts)
    end,
  },
}
