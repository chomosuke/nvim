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
  require('util').create_autocmds('load_jdtls_upon_ft_java', {
    {
      event = 'FileType',
      opts = {
        pattern = 'java',
        callback = function()
          require('jdtls').start_or_attach {
            cmd = {
              require('mason-registry').get_package('jdtls'):get_install_path()
                .. '/bin/jdtls',
            },
            root_dir = vim.fs.dirname(
              vim.fs.find({ '.gradlew', '.git', 'mvnw' }, { upward = true })[1]
            ),
          }
        end,
      },
    },
  })
end
