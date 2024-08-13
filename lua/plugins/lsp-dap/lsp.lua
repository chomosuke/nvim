require('mason-lspconfig').setup()

local M = {}

function M.gen_config(server_name, config)
  config = config or {}
  config.capabilities = require('cmp_nvim_lsp').default_capabilities()
  config.before_init = function(_, config_)
    if type(config_.root_dir) ~= 'string' then
      print(
        'config.root_dir is not a string: ' .. vim.inspect(config_.root_dir)
      )
      return
    end
    local p_config =
      require('project-config').get_lsp_config(server_name, config_.root_dir)
    if p_config ~= nil then
      if p_config.settings ~= nil then
        config_.settings = p_config.settings
      end
      if p_config.cmd ~= nil then
        config_.cmd = p_config.cmd
      end
    end
  end
  return config
end

require('neodev').setup {}

local lspconfig = require 'lspconfig'

-- Self installed lsps:
lspconfig.ocamllsp.setup {}

local function null() end
require('mason-lspconfig').setup_handlers {
  rust_analyzer = null,
  jdtls = null,
  ocamllsp = null,
  function(server_name)
    lspconfig[server_name].setup(M.gen_config(server_name))
  end,
  ltex = function()
    lspconfig.ltex.setup(M.gen_config('ltex', {
      filetypes = { 'markdown', 'tex' },
      on_attach = function()
        require('ltex_extra').setup {
          load_langs = { 'en-US' },
          path = vim.fn.stdpath 'data' .. '/ltex_extra',
        }
      end,
    }))
  end,
  lua_ls = function()
    lspconfig.lua_ls.setup(M.gen_config('lua_ls', {
      settings = {
        Lua = {
          workspace = {
            checkThirdParty = false,
          },
        },
      },
    }))
  end,
  als = function()
    lspconfig.als.setup(M.gen_config('als', {
      cmd = { 'ada_language_server' },
    }))
  end,
  pylsp = function()
    lspconfig.pylsp.setup {
      settings = {
        pylsp = {
          plugins = {
            autopep8 = {
              -- use yapf
              enabled = false,
            },
            pycodestyle = {
              maxLineLength = 88,
            },
          },
        },
      },
    }
  end,
}

vim.api.nvim_set_hl(0, 'LspInfoBorder', {
  fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID 'Comment'), 'fg#'),
})
require('lspconfig.ui.windows').default_options.border = 'rounded'

return M
