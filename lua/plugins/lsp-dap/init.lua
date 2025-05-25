return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile', 'CmdlineEnter' },
    config = function()
      require('mason').setup { ui = { border = 'rounded' } }

      -- more logging -> better debugging
      -- vim.lsp.set_log_level(0)

      require 'plugins.lsp-dap.lsp'
      require 'plugins.lsp-dap.dap'
      require 'plugins.lsp-dap.both'
      require 'plugins.lsp-dap.mapping'

      -- Format on save
      local lsp = require 'plugins.lsp-dap.lsp'
      local util = require 'util'
      util.create_autocmds('format_on_save', {
        {
          event = 'BufWritePre',
          opts = {
            callback = function()
              lsp.format()
            end,
          },
        },
      })
    end,
    dependencies = {
      -- mason
      'mason-org/mason.nvim',
      'mason-org/mason-lspconfig.nvim',
      'jay-babu/mason-nvim-dap.nvim',

      -- dap
      'rcarriga/nvim-dap-ui',
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio',

      -- tools that uses the lsp
      {
        'mrcjkb/rustaceanvim',
        version = '^5', -- Recommended
        lazy = false,   -- This plugin is already lazy
      },

      'akinsho/flutter-tools.nvim',
      'nvim-lua/plenary.nvim',

      'barreiroleo/ltex_extra.nvim',

      'folke/neodev.nvim',

      'mfussenegger/nvim-jdtls',
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
      wk.add {
        ',l',
        function()
          local virtual_lines = lsp_lines.toggle()
          vim.diagnostic.config { virtual_text = not virtual_lines }
        end,
        desc = 'toggle diagnostic virtual lines',
      }
    end,
  },
}
