return function(use)
  use {
    'neovim/nvim-lspconfig',
    config = function()
      -- easy install
      require('mason').setup {}

      -- lsp
      require('mason-lspconfig').setup {}

      -- more logging -> better debugging
      -- vim.lsp.set_log_level(0)

      -- keymaps
      local wk = require 'which-key'
      DiagnosticOn = true
      wk.register {
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
          r = { vim.lsp.buf.rename, 'rename' },
          a = { vim.lsp.buf.code_action, 'code actions' },
          f = {
            function()
              vim.lsp.buf.format {
                async = true,
                filter = function(client)
                  return client.name ~= 'sumneko_lua'
                    or not require('mason-registry').is_installed 'stylua'
                end,
              }
            end,
            'format',
          },
          w = {
            name = 'workspace',
            a = { vim.lsp.buf.add_workspace_folder, 'add folder' },
            r = { vim.lsp.buf.remove_workspace_folder, 'remove folder' },
            l = {
              function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
              end,
              'list folder',
            },
          },
          d = {
            name = 'diagnostic',
            f = { vim.diagnostic.open_float, 'open float' },
            p = { vim.diagnostic.goto_prev, 'go to previous' },
            n = { vim.diagnostic.goto_next, 'go to next' },
            l = { vim.diagnostic.setloclist, 'list' },
            t = {
              function()
                if DiagnosticOn then
                  vim.diagnostic.disable()
                  DiagnosticOn = false
                else
                  vim.diagnostic.enable()
                  DiagnosticOn = true
                end
              end,
              'toggle',
            },
          },
        },
        -- map <leader>, back to , for actual , usage
        ['<leader>,'] = { ',', 'actual ,' },
      }
      wk.register(
        { ['<C-s>'] = { vim.lsp.buf.signature_help, 'signiture help' } },
        { mode = 'i' }
      )

      local function on_attach(client, _)
        -- load project specific settings for lsp
        local settings = require('project-config').get_lsp_config()[client.name]
        if settings ~= nil then
          client.config.settings = settings
        end
      end

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- dap
      local dap, dapui = require 'dap', require 'dapui'

      require('mason-nvim-dap').setup {
        automatic_setup = { filetypes = { codelldb = { 'c', 'cpp' } } },
      }
      require('mason-nvim-dap').setup_handlers()

      dapui.setup {
        layouts = {
          {
            elements = {
              { id = 'scopes', size = 0.55 },
              { id = 'watches', size = 0.25 },
              { id = 'breakpoints', size = 0.1 },
              { id = 'stacks', size = 0.1 },
            },
            size = 40,
            position = 'left',
          },
          {
            elements = {
              { id = 'console', size = 0.6 },
              { id = 'repl', size = 0.4 },
            },
            size = 15,
            position = 'bottom',
          },
        },
      }
      -- auto open dapui
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open {}
        require('nvim-tree.api').tree.close()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close {}
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close {}
      end

      -- dap keymap
      wk.register {
        [',e'] = {
          name = 'debugger',
          c = { dap.continue, 'start/continue' },
          n = { dap.step_over, 'step over' },
          i = { dap.step_into, 'step into' },
          o = { dap.step_out, 'step out' },
          b = {
            name = 'breakpoint',
            t = { dap.toggle_breakpoint, 'toggle' },
            c = {
              function()
                dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
              end,
              'set conditional',
            },
            l = {
              function()
                dap.set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
              end,
              'set log point',
            },
            i = { dap.list_breakpoints, 'list' },
            r = { dap.clear_breakpoints, 'clear' },
          },
          r = { dap.repl.toggle, 'toggle repl' },
          l = { dap.run_last, 'run last' },
          t = {
            function()
              dap.terminate()
              dapui.close {}
            end,
            'terminate',
          },
          p = { dap.pause, 'pause' },
          u = { dap.run_to_cursor, 'run until cursor' },
        },
      }

      -- setup lsps
      local lspconfig = require 'lspconfig'
      require('mason-lspconfig').setup_handlers {
        function(server_name)
          lspconfig[server_name].setup {
            on_attach = on_attach,
            capabilities = capabilities,
          }
        end,
        ltex = function()
          lspconfig.ltex.setup {
            filetypes = { 'markdown', 'tex' },
            on_attach = function(client, bufnr)
              on_attach(client, bufnr)
              require('ltex_extra').setup {
                load_langs = { 'en-US' },
                path = vim.fn.stdpath 'data' .. '/ltex_extra',
              }
            end,
            capabilities = capabilities,
          }
        end,
        rust_analyzer = function()
          require('rust-tools').setup {
            server = {
              on_attach = on_attach,
              capabilities = capabilities,
            },
            dap = {
              adapter = dap.adapters.codelldb,
            },
            tools = {
              hover_actions = {
                auto_focus = true,
              },
            },
          }
        end,
      }

      require('flutter-tools').setup {
        lsp = {
          on_attach = on_attach,
          capabilities = capabilities,
        },
      }

      -- null-ls
      require('mason-null-ls').setup {
        automatic_setup = true,
      }
      require('mason-null-ls').setup_handlers {}
      require('null-ls').setup()
    end,
    requires = {
      -- mason
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'jay-babu/mason-nvim-dap.nvim',
      'jay-babu/mason-null-ls.nvim',

      -- null-ls
      'jose-elias-alvarez/null-ls.nvim',

      -- dap
      'rcarriga/nvim-dap-ui',
      'mfussenegger/nvim-dap',

      -- tools that uses the lsp
      'simrat39/rust-tools.nvim',
      'nvim-lua/plenary.nvim',
      'akinsho/flutter-tools.nvim',
      'nvim-lua/plenary.nvim',
      'chomosuke/ltex_extra.nvim',
    },
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
end
