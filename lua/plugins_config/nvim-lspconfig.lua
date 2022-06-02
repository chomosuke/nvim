return function()
  require 'nvim-lsp-installer'.setup {
    automatic_installation = true,
  }
  local lspconfig = require 'lspconfig'
  lspconfig.rust_analyzer.setup {
    settings = {
      ['rust-analyzer'] = {
        checkOnSave = {
          command = 'clippy',
        },
      },
    },
  }
  lspconfig.sumneko_lua.setup {}
  lspconfig.hls.setup {}
  lspconfig.intelephense.setup {}
end
