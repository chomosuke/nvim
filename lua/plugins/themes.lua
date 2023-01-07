return {
  {
    'Mofiqul/vscode.nvim',
    config = function()
      vim.g.vscode_italic_comment = 1
      vim.g.vscode_disable_nvimtree_bg = true
    end,
    priority = 1000,
  },
  { 'rmehri01/onenord.nvim', priority = 1000 },
  { 'navarasu/onedark.nvim', priority = 1000 },
  { 'marko-cerovac/material.nvim', priority = 1000 },
  {
    'sainnhe/gruvbox-material',
    config = function()
      vim.gruvbox_material_enable_italic = 1
    end,
    priority = 1000,
  },
  { 'projekt0n/github-nvim-theme', priority = 1000 },
  { 'folke/tokyonight.nvim', priority = 1000 },
}
