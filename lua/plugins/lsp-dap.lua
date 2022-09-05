return function(use)
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'

  use {
    'neovim/nvim-lspconfig',
    config = function()
      -- easy install lsp
      require 'mason'.setup {}
      require 'mason-lspconfig'.setup {}

      -- more logging -> better debugging
      -- vim.lsp.set_log_level(0)

      -- keymaps
      local wk = require 'which-key'
      wk.register {
        [',d'] = {
          name = 'diagnostic',
          f = { vim.diagnostic.open_float, 'open float' },
          p = { vim.diagnostic.goto_prev, 'go to previous' },
          n = { vim.diagnostic.goto_next, 'go to next' },
          l = { vim.diagnostic.setloclist, 'list' },
        },
        -- map <leader>, back to , for actual , usage
        ['<leader>,'] = { ',', 'actual ,' },
      }

      local function on_attach(client, bufnr)
        -- keymaps
        wk.register(
          {
            [','] = {
              name = 'lsp',
              g = {
                name = 'go to',
                D = { vim.lsp.buf.declaration, 'declaration' },
                d = { vim.lsp.buf.definition, 'definition' },
                t = { vim.lsp.buf.type_definition, 'type definition' },
                i = { vim.lsp.buf.implementation, 'implementation' },
                r = { vim.lsp.buf.references, 'references' },
              },
              h = { vim.lsp.buf.hover, 'hover' },
              rn = { vim.lsp.buf.rename, 'rename' },
              ca = { vim.lsp.buf.code_action, 'code actions' },
              f = { vim.lsp.buf.formatting, 'format' },
              w = {
                name = 'workspace',
                a = { vim.lsp.buf.add_workspace_folder, 'add folder' },
                r = { vim.lsp.buf.remove_workspace_folder, 'remove folder' },
                l = { function()
                  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, 'list folder' }
              }
            },
          },
          { buffer = bufnr }
        )
        wk.register(
          { ['<C-s>'] = { vim.lsp.buf.signature_help, 'signiture help' } },
          { buffer = bufnr, mode = 'i' }
        )

        -- load project specific settings for lsp
        local settings = require 'project-config'.get_lsp_config()[client.name]
        if settings ~= nil then
          client.config.settings = settings
        end
      end

      -- setup lsps
      local lspconfig = require 'lspconfig'
      local servers = {
        'intelephense',
        'tsserver',
        'csharp_ls',
        'sumneko_lua',
        'yamlls',
        'jsonls',
        'clangd',
        'hls',
        'jdtls',
        'texlab',
        'clojure_lsp',
        'dockerls',
      }
      for _, lsp in pairs(servers) do
        lspconfig[lsp].setup {
          on_attach = on_attach,
        }
      end

      -- setup lsp with special settings
      lspconfig.ltex.setup {
        filetypes = { 'markdown', 'tex' },
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          require 'ltex_extra'.setup {
            load_langs = { 'en-US' },
            path = vim.fn.stdpath('data') .. '/ltex_extra',
          }
        end,
      }

      -- setup tools that uses the lsp
      require 'rust-tools'.setup {
        server = {
          on_attach = on_attach,
        },
      }
      require 'flutter-tools'.setup {
        lsp = {
          on_attach = on_attach,
        },
      }
    end,
  }

  use 'chomosuke/ltex_extra.nvim'

  -- tools that uses the lsp
  use {
    'simrat39/rust-tools.nvim',
    requires = 'nvim-lua/plenary.nvim',
  }
  use {
    'akinsho/flutter-tools.nvim',
    requires = 'nvim-lua/plenary.nvim',
  }

  use {
    'Maan2003/lsp_lines.nvim',
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
  }

  -- use {
  --   'rcarriga/nvim-dap-ui',
  --   requires = 'mfussenegger/nvim-dap',
  --   config = function()
  --     local dap, dapui = require 'dap', require 'dapui'
  --     dap.adapters.codelldb = {
  --       type = 'server',
  --       port = "${port}",
  --       executable = {
  --         command = 'C:\\Users\\a1332\\AppData\\Local\\nvim-data\\mason\\bin\\codelldb.cmd',
  --         args = { "--port", "${port}" },
  --
  --         -- On windows you may have to uncomment this:
  --         detached = false,
  --       }
  --     }
  --     dap.configurations.cpp = {
  --       {
  --         name = "Launch file",
  --         type = "codelldb",
  --         request = "launch",
  --         program = function()
  --           return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
  --         end,
  --         cwd = '${workspaceFolder}',
  --         stopOnEntry = true,
  --       },
  --     }
  --     dapui.setup {}
  --   end,
  -- }
end
