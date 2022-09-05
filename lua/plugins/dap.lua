return function(use)
  use {
    'rcarriga/nvim-dap-ui',
    requires = 'mfussenegger/nvim-dap',
    config = function()
      local dap, dapui = require 'dap', require 'dapui'

      -- cpp
      dap.adapters.codelldb = {
        type = 'server',
        port = '${port}',
        executable = {
          command = vim.fn.stdpath 'data' ..
              '/mason/bin/codelldb' ..
              (require 'util'.is_windows() and '.cmd' or ''),
          args = { '--port', '${port}' },
        }
      }
      dap.configurations.cpp = {
        {
          name = 'Launch',
          type = 'codelldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
      }

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
              -- 'repl',
              'console',
            },
            size = 15,
            position = 'bottom',
          },
        },
      }
      -- auto open dapui
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open {}
        require 'nvim-tree.api'.tree.close()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close {}
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close {}
      end

      -- dap keymap
      local wk = require 'which-key'
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
              function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
              'set conditional',
            },
            l = {
              function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
              'set log point',
            },
            i = { dap.list_breakpoints, 'list' },
            r = { dap.clear_breakpoints, 'clear' },
          },
          r = { dap.repl.toggle, 'toggle repl' },
          l = { dap.run_last, 'run last' },
          t = { dap.terminate, 'terminate' },
          p = { dap.pause, 'pause' },
          u = { dap.run_to_cursor, 'run until cursor' },
        },
      }
    end,
  }
end
