require('mason-lspconfig').setup {
  automatic_enable = {
    exclude = {
      'rust_analyzer',
      'jdtls',
      'ocamllsp'
    }
  }
}

local M = {}

vim.lsp.inlay_hint.enable()

function M.format()
  vim.lsp.buf.format {
    filter = function(client)
      return require('project-config').get_format_enabled(client.name, 0)
    end,
  }
end

function M.gen_config(server_name, config)
  config = config or {}
  config.capabilities = require('cmp_nvim_lsp').default_capabilities()
  local p_config = require('project-config').get_lsp_config(server_name)
  if p_config ~= nil then
    if p_config.settings ~= nil then
      config.settings = p_config.settings
    end
    if p_config.cmd ~= nil then
      config.cmd = p_config.cmd
    end
  end
  return config
end

require('neodev').setup {}

-- Self installed lsps:
local function config(name, cfg)
  vim.lsp.config[name] = vim.tbl_deep_extend(
    'force',
    vim.lsp.config[name] or {},
    M.gen_config(name, cfg)
  )
end
vim.lsp.enable('ocamllsp')

local mappings = require "mason-lspconfig.mappings"
local registry = require "mason-registry"
-- for _, mason_pkg in pairs(registry.get_all_package_names()) do
for _, mason_pkg in pairs(registry.get_installed_package_names()) do
  local name = mappings.get_mason_map().package_to_lspconfig[mason_pkg]
  if name == 'ltex' then
    config(name, {
      filetypes = { 'markdown', 'tex' },
      on_attach = function()
        require('ltex_extra').setup {
          load_langs = { 'en-US' },
          path = vim.fn.stdpath 'data' .. '/ltex_extra',
        }
      end,
    })
  elseif name == 'lua_ls' then
    config(name, {
      settings = {
        Lua = {
          workspace = {
            checkThirdParty = false,
          },
        },
      },
    })
  elseif name == 'pylsp' then
    config(name, {
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
    })
  elseif name ~= nil then
    config(name)
  end
end

vim.api.nvim_set_hl(0, 'LspInfoBorder', {
  fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID 'Comment'), 'fg#'),
})
require('lspconfig.ui.windows').default_options.border = 'rounded'

return M
