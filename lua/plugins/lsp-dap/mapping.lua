-- lsp
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
          filter = function(client)
            return require('project-config').get_format_enabled(
              client.name,
              0
            )
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

-- dap
local dap, dapui = require 'dap', require 'dapui'
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
