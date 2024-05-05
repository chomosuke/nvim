local gen_config = require('plugins.lsp-dap.lsp').gen_config
local wk = require 'which-key'
local rt = require 'rust-tools'
rt.setup {
  server = gen_config('rust_analyzer', {
    on_attach = function(_, bufnr)
      wk.register({
        [','] = {
          name = 'lsp',
          h = { rt.hover_actions.hover_actions, 'hover' },
          -- a = { rt.code_action_group.code_action_group, 'code actions' }
        },
      }, { buffer = bufnr })
    end,
  }),
  dap = {
    adapter = require('dap').adapters.codelldb,
  },
}

require('flutter-tools').setup {
  lsp = gen_config 'dartls',
  debugger = {
    enabled = true,
  },
}

require('util').create_autocmds('load_jdtls_upon_ft_java', {
  {
    event = 'FileType',
    opts = {
      pattern = 'java',
      callback = function()
        local mason_registry = require 'mason-registry'
        local jdtls = require 'jdtls'
        jdtls.start_or_attach(gen_config('jdtls', {
          cmd = {
            mason_registry.get_package('jdtls'):get_install_path()
              .. '/bin/jdtls',
          },
          root_dir = vim.fs.dirname(
            vim.fs.find(
              { '.gradlew', '.git', 'mvnw', 'pom.xml' },
              { upward = true }
            )[1]
          ),
          init_options = {
            bundles = {
              vim.fn.glob(
                mason_registry
                  .get_package('java-debug-adapter')
                  :get_install_path()
                  .. '/extension/server/com.microsoft.java.debug.plugin-*.jar',
                true
              ),
            },
          },
          on_attach = function()
            jdtls.setup_dap()
          end,
        }))
      end,
    },
  },
})
