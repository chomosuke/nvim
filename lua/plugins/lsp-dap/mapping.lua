local lsp = require 'plugins.lsp-dap.lsp'

-- lsp
local wk = require 'which-key'
DiagnosticOn = true
wk.add {
  { ',',   group = 'lsp' },
  { ',g',  group = 'go to' },
  { ',gg', vim.lsp.buf.definition,              desc = 'definition' },
  { ',gd', vim.lsp.buf.declaration,             desc = 'declaration' },
  { ',gt', vim.lsp.buf.type_definition,         desc = 'type definition' },
  { ',gi', vim.lsp.buf.implementation,          desc = 'implementation' },
  { ',gr', vim.lsp.buf.references,              desc = 'references' },
  { ',ht', vim.lsp.buf.hover,                   desc = 'hover' },
  { ',s',  vim.lsp.buf.signature_help,          desc = 'signiture help' },
  { ',r',  vim.lsp.buf.rename,                  desc = 'rename' },
  { ',a',  vim.lsp.buf.code_action,             desc = 'code actions' },
  { ',f',  lsp.format,                          desc = 'format', },
  { ',w',  group = 'workspace' },
  { ',wa', vim.lsp.buf.add_workspace_folder,    desc = 'add folder' },
  { ',wr', vim.lsp.buf.remove_workspace_folder, desc = 'remove folder' },
  {
    ',wl',
    function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end,
    desc = 'list folder',
  },
  { ',e',  group = 'diagnostic' },
  {
    ',ef',
    function()
      vim.diagnostic.open_float { source = true }
    end,
    desc = 'open float',
  },
  { ',ep', vim.diagnostic.goto_prev,  desc = 'go to previous' },
  { ',en', vim.diagnostic.goto_next,  desc = 'go to next' },
  { ',el', vim.diagnostic.setloclist, desc = 'list' },
  {
    ',et',
    function()
      if DiagnosticOn then
        vim.diagnostic.enable(false)
        DiagnosticOn = false
      else
        vim.diagnostic.enable()
        DiagnosticOn = true
      end
    end,
    desc = 'toggle',
  },

  -- map <leader>, back to , for actual , usage
  { '<leader>,', ',', desc = 'actual ,' },

  {
    '<C-s>',
    vim.lsp.buf.signature_help,
    desc = 'signiture help',
    mode = { 'i', 'n' },
  },
}

-- -- dap
-- local dap, dapui = require 'dap', require 'dapui'
-- wk.add {
--   { ',e',   group = 'debugger' },
--   { ',ec',  dap.continue,          desc = 'start/continue' },
--   { ',en',  dap.step_over,         desc = 'step over' },
--   { ',ei',  dap.step_into,         desc = 'step into' },
--   { ',eo',  dap.step_out,          desc = 'step out' },
--   { ',eb',  group = 'debugger' },
--   { ',ebt', dap.toggle_breakpoint, desc = 'toggle' },
--   {
--     ',ebc',
--     function()
--       dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
--     end,
--     desc = 'set conditional',
--   },
--   {
--     ',ebl',
--     function()
--       dap.set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
--     end,
--     desc = 'set log point',
--   },
--   { ',ebi', dap.list_breakpoints,  desc = 'list' },
--   { ',ebr', dap.clear_breakpoints, desc = 'clear' },
--   { ',er',  dap.repl.toggle,       desc = 'toggle repl' },
--   { ',el',  dap.run_last,          desc = 'run last' },
--   {
--     ',et',
--     function()
--       dap.terminate()
--       dapui.close {}
--     end,
--     desc = 'terminate',
--   },
--   { ',ep', dap.pause,         desc = 'pause' },
--   { ',eu', dap.run_to_cursor, desc = 'run until cursor' },
-- }
