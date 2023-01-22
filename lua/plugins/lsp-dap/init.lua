return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile', 'CmdlineEnter' },
    config = function()
      require('mason').setup { ui = { border = 'rounded' } }

      -- more logging -> better debugging
      -- vim.lsp.set_log_level(0)

      local on_attach, capabilities = require 'plugins.lsp-dap.lsp'
      require 'plugins.lsp-dap.null-ls'
      require 'plugins.lsp-dap.dap'
      require 'plugins.lsp-dap.both'(on_attach, capabilities)
      require 'plugins.lsp-dap.mapping'
    end,
    dependencies = {
      -- mason
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'jay-babu/mason-nvim-dap.nvim',
      'jay-babu/mason-null-ls.nvim',

      -- null-ls
      'jose-elias-alvarez/null-ls.nvim',
      'nvim-lua/plenary.nvim',

      -- dap
      'rcarriga/nvim-dap-ui',
      'mfussenegger/nvim-dap',

      -- tools that uses the lsp
      'simrat39/rust-tools.nvim',
      'nvim-lua/plenary.nvim',
      'akinsho/flutter-tools.nvim',
      'nvim-lua/plenary.nvim',
      'barreiroleo/ltex_extra.nvim',
      'folke/neodev.nvim',
    },
  },

  {
    url = 'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    keys = ',l',
    config = function()
      local lsp_lines = require 'lsp_lines'
      lsp_lines.setup()
      lsp_lines.toggle() -- turn off at first

      local wk = require 'which-key'
      wk.register {
        [',l'] = {
          function()
            local virtual_lines = lsp_lines.toggle()
            vim.diagnostic.config { virtual_text = not virtual_lines }
          end,
          'toggle diagnostic virtual lines',
        },
      }
    end,
  },
}
