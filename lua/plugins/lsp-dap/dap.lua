local dap, dapui = require 'dap', require 'dapui'

require('mason-nvim-dap').setup {
  automatic_setup = { filetypes = { codelldb = { 'c', 'cpp' } } },
  handlers = {
    require('mason-nvim-dap').default_setup,
    codelldb = function(config)
      config.filetypes = { 'c', 'cpp' }
      require('mason-nvim-dap').default_setup(config)
    end,
  },
}

dapui.setup {
  layouts = {
    {
      elements = {
        { id = 'scopes', size = 0.55 },
        { id = 'watches', size = 0.25 },
        { id = 'stacks', size = 0.25 },
        { id = 'breakpoints', size = 0.1 },
      },
      size = 40,
      position = 'left',
    },
    {
      elements = {
        { id = 'console', size = 0.7 },
        { id = 'repl', size = 0.3 },
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

dap.listeners.after.event_initialized['no-cpp-except-brkpt'] = function(session)
  if session.config.type == 'codelldb' then
    require('dap.repl').execute 'breakpoint name configure --disable cpp_exception'
  end
end
