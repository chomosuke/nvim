require('mason-lspconfig').setup()

local function on_attach(client, bufnr)
  -- load project specific settings for lsp
  local settings = require('project-config').get_lsp_config(client.name, bufnr)
  if settings ~= nil then
    client.config.settings = settings
  end
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('neodev').setup {}

local lspconfig = require 'lspconfig'
local function null() end
require('mason-lspconfig').setup_handlers {
  rust_analyzer = null,
  function(server_name)
    lspconfig[server_name].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end,
  ltex = function()
    lspconfig.ltex.setup {
      filetypes = { 'markdown', 'tex' },
      on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        require('ltex_extra').setup {
          load_langs = { 'en-US' },
          path = vim.fn.stdpath 'data' .. '/ltex_extra',
        }
      end,
      capabilities = capabilities,
    }
  end,
  sumneko_lua = function()
    lspconfig.sumneko_lua.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          workspace = {
            checkThirdParty = false,
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

return on_attach, capabilities
