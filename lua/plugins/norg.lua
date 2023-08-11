require('util').create_autocmds('setup_keybind_for_norg', {
  {
    event = 'FileType',
    opts = {
      callback = function()
        require('which-key').register({
          [',n'] = {
            function()
              vim.cmd [[
                :Neorg toggle-concealer
              ]]
            end,
            'Toggle concealer',
          },
        }, { buffer = 0 })

        vim.bo.softtabstop = 4
        vim.bo.shiftwidth = 4
        vim.bo.tabstop = 4
        vim.bo.expandtab = true
        vim.bo.tw = 100
        vim.cmd 'setlocal colorcolumn=101'
        vim.cmd 'setlocal conceallevel=3'
      end,
      pattern = 'norg',
    },
  },
})

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
