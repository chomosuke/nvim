return function(use)
  use {
    'ms-jpq/coq_nvim',
    branch = 'coq',
    requires = {
      { 'ms-jpq/coq.artifacts', branch = 'artifacts' },
      { 'ms-jpq/coq.thirdparty', branch = '3p' },
    },
    config = function()
      vim.g.coq_settings = {
        auto_start = true,
        display = {
          icons = {
            mode = 'short',
          },
        },
        limits = {
          completion_auto_timeout = 2,
          completion_manual_timeout = 10,
        },
        clients = {
          lsp = {
            resolve_timeout = 2,
            -- lsp should be prioritized
            weight_adjust = 2,
          },
        },
      }
      require 'coq'
    end,
  }
end
