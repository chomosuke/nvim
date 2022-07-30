return function(use)
  use {
    'Mofiqul/vscode.nvim',
    config = function()
      vim.g.vscode_italic_comment = 1
      vim.g.vscode_disable_nvimtree_bg = true
    end,
  }
  use 'rmehri01/onenord.nvim'
  use 'navarasu/onedark.nvim'
  use 'marko-cerovac/material.nvim'
  use {
    'sainnhe/gruvbox-material',
    config = function()
      vim.gruvbox_material_enable_italic = 1
    end,
  }
  use 'projekt0n/github-nvim-theme'
  use 'folke/tokyonight.nvim'
end
