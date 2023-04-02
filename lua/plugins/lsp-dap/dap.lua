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
