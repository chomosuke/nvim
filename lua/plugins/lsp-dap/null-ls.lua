local null_ls = require 'null-ls'
require('mason-null-ls').setup {
  handlers = {
    function(source_name, methods)
      for _, method in pairs(methods) do
        null_ls.register(null_ls.builtins[method][source_name].with {
          runtime_condition = function()
            return require('project-config').get_null_ls_source_enabled(
              source_name
            )
          end,
        })
      end
    end,
  },
}
null_ls.setup()
