local util = require 'util'
local gen_config = require('plugins.lsp-dap.lsp').gen_config

local wk = require 'which-key'
util.create_autocmds('set_spell_for_spell_check', {
  {
    event = 'FileType',
    opts = {
      callback = function(opts)
        -- wk.add {
        --   {
        --     ',a',
        --     function()
        --       vim.cmd.RustLsp 'codeAction' -- supports rust-analyzer's grouping
        --       -- or vim.lsp.buf.codeAction() if you don't want grouping.
        --     end,
        --     bufnr = opts.buf,
        --   },
        -- }
      end,
      pattern = {
        'rust',
      },
    },
  },
})

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
