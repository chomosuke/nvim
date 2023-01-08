return {
  {
    'Mofiqul/vscode.nvim',
    config = function()
      vim.g.vscode_italic_comment = 1
      vim.g.vscode_disable_nvimtree_bg = true
    end,
  },
  'rmehri01/onenord.nvim',
  'navarasu/onedark.nvim',
  'marko-cerovac/material.nvim',
  {
    'sainnhe/gruvbox-material',
    config = function()
      vim.gruvbox_material_enable_italic = 1
    end,
  },
  'projekt0n/github-nvim-theme',
  'folke/tokyonight.nvim',
}
