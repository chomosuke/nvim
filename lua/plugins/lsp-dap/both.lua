return function(on_attach, capabilities)
  require('rust-tools').setup {
    server = {
      on_attach = on_attach,
      capabilities = capabilities,
    },
    dap = {
      adapter = require('dap').adapters.codelldb,
    },
    tools = {
      hover_actions = {
        auto_focus = true,
      },
    },
  }
  require('flutter-tools').setup {
    lsp = {
      on_attach = on_attach,
      capabilities = capabilities,
    },
  }
end
