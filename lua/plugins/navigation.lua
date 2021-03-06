return function(use)
  use {
    'ggandor/leap.nvim',
    config = function()
      require 'leap'.set_default_keymaps()
    end
  }
  use {
    'phaazon/hop.nvim',
    config = function()
      require 'hop'.setup { keys = 'aoeuhtnsidpgcrlyfqjkmwvzxb' }
      require 'map'.map('<Leader>e', '<cmd>HopLine<CR>')
    end
  }
  use {
    'ziontee113/syntax-tree-surfer',
    config = function()
      require 'syntax-tree-surfer'

      local opts = { noremap = true, silent = true }

      -- Normal Mode Swapping:
      -- Swap The Master Node relative to the cursor with it's siblings, Dot Repeatable
      vim.keymap.set("n", "<Leader>sU", function()
        vim.opt.opfunc = "v:lua.STSSwapUpNormal_Dot"
        return "g@l"
      end, { silent = true, expr = true })
      vim.keymap.set("n", "<Leader>sD", function()
        vim.opt.opfunc = "v:lua.STSSwapDownNormal_Dot"
        return "g@l"
      end, { silent = true, expr = true })

      -- Swap Current Node at the ursor with it's siblings, Dot Repeatable
      vim.keymap.set("n", "<Leader>sd", function()
        vim.opt.opfunc = "v:lua.STSSwapCurrentNodeNextNormal_Dot"
        return "g@l"
      end, { silent = true, expr = true })
      vim.keymap.set("n", "<Leader>su", function()
        vim.opt.opfunc = "v:lua.STSSwapCurrentNodePrevNormal_Dot"
        return "g@l"
      end, { silent = true, expr = true })

      -- Visual Selection from Normal Mode
      vim.keymap.set("n", "<Leader>sx", '<cmd>STSSelectMasterNode<CR>', opts)
      vim.keymap.set("n", "<Leader>sn", '<cmd>STSSelectCurrentNode<CR>', opts)

      -- Select Nodes in Visual Mode
      vim.keymap.set("x", "J", '<cmd>STSSelectNextSiblingNode<CR>', opts)
      vim.keymap.set("x", "K", '<cmd>STSSelectPrevSiblingNode<CR>', opts)
      vim.keymap.set("x", "H", '<cmd>STSSelectParentNode<CR>', opts)
      vim.keymap.set("x", "L", '<cmd>STSSelectChildNode<CR>', opts)

      -- Swapping Nodes in Visual Mode
      vim.keymap.set("x", "<A-j>", '<cmd>STSSwapNextVisual<CR>', opts)
      vim.keymap.set("x", "<A-k>", '<cmd>STSSwapPrevVisual<CR>', opts)
    end,
  }
end
