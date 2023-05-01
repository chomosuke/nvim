return {
  {
    'nvim-neorg/neorg',
    cmd = 'Neorg',
    ft = 'norg',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    build = ':Neorg sync-parsers',
    opts = {
      load = {
        ['core.defaults'] = {},
        ['core.concealer'] = {},
        ['core.completion'] = { config = { engine = 'nvim-cmp' } },
      },
    },
  },
}
