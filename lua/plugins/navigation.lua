return function(use)
  use {
    'ggandor/leap.nvim',
    config = function()
      require 'leap'.setup {
        equivalence_classes = {
          {
            ' \t\r\n',
            ')]}>',
            '([{<',
            { '"', "'", '`' },
          }
        },
        safe_labels = {},
        labels = {
          'e', 'u', 'o', 'a', 'i', 't', 'h', 'n', 's', 'd',
          '.', 'p', ';', 'y', 'c', 'g', 'r', 'z', 'f',
          'k', 'q', 'j', 'x', 'm', 'v', 'w', 'b', "'", 'l',
          'E', 'U', 'O', 'A', 'I', 'T', 'H', 'N', 'S', 'D',
          '>', 'P', ':', 'Y', 'C', 'G', 'R', 'Z', 'F',
          'K', 'Q', 'J', 'X', 'M', 'V', 'W', 'B', '"', 'L',
        },
      }
      require 'leap'.set_default_keymaps()
    end
  }

  use {
    'phaazon/hop.nvim',
    config = function()
      require 'hop'.setup { keys = 'aoeuhtnsidpgcrlyfqjkmwvzxb' }
      require 'which-key'.register({
        ['<leader>'] = {
          e = { '<cmd>HopChar2<CR>', 'hop 2char' },
          o = { '<cmd>HopWord<CR>', 'hop word' },
          u = { '<cmd>HopLine<CR>', 'hop line' },
        }
      }, {})
    end
  }

  use {
    'ziontee113/syntax-tree-surfer',
    config = function()
      require 'syntax-tree-surfer'

      local opts = { noremap = true, silent = true }

      -- Normal Mode Swapping:
      -- Swap The Master Node relative to the cursor with it's siblings, Dot Repeatable
      vim.keymap.set('n', '<leader>sU', function()
        vim.opt.opfunc = 'v:lua.STSSwapUpNormal_Dot'
        return 'g@l'
      end, { silent = true, expr = true })
      vim.keymap.set('n', '<leader>sD', function()
        vim.opt.opfunc = 'v:lua.STSSwapDownNormal_Dot'
        return 'g@l'
      end, { silent = true, expr = true })

      -- Swap Current Node at the ursor with it's siblings, Dot Repeatable
      vim.keymap.set('n', '<leader>sd', function()
        vim.opt.opfunc = 'v:lua.STSSwapCurrentNodeNextNormal_Dot'
        return 'g@l'
      end, { silent = true, expr = true })
      vim.keymap.set('n', '<leader>su', function()
        vim.opt.opfunc = 'v:lua.STSSwapCurrentNodePrevNormal_Dot'
        return 'g@l'
      end, { silent = true, expr = true })

      -- Visual Selection from Normal Mode
      vim.keymap.set('n', '<leader>sx', '<cmd>STSSelectMasterNode<CR>', opts)
      vim.keymap.set('n', '<leader>sn', '<cmd>STSSelectCurrentNode<CR>', opts)

      -- Select Nodes in Visual Mode
      vim.keymap.set('x', 'J', '<cmd>STSSelectNextSiblingNode<CR>', opts)
      vim.keymap.set('x', 'K', '<cmd>STSSelectPrevSiblingNode<CR>', opts)
      vim.keymap.set('x', 'H', '<cmd>STSSelectParentNode<CR>', opts)
      vim.keymap.set('x', 'L', '<cmd>STSSelectChildNode<CR>', opts)

      -- Swapping Nodes in Visual Mode
      vim.keymap.set('x', '<A-j>', '<cmd>STSSwapNextVisual<CR>', opts)
      vim.keymap.set('x', '<A-k>', '<cmd>STSSwapPrevVisual<CR>', opts)
    end,
  }
end
