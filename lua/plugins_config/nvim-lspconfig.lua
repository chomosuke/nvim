return function()
  -- easy install lsp
  require 'nvim-lsp-installer'.setup {
    automatic_installation = { exclude = { 'rust_analyzer' } },
  }

  -- project lsp settings
  require 'nlspsettings'.setup {
    loader = 'yaml',
    append_default_schemas = true,
    local_settings_root_markers = {
      '.git',
      '.nlsp-settings',
    }
  }

  -- more logging -> better debugging
  vim.lsp.set_log_level(0)

  -- mappings
  local map = require 'map'
  map.nmap(',df', vim.diagnostic.open_float)
  map.nmap(',dp', vim.diagnostic.goto_prev)
  map.nmap(',dn', vim.diagnostic.goto_next)
  map.nmap(',dl', vim.diagnostic.setloclist)

  local function on_attach(client, bufnr)
    local function bmap(keys, mapping)
      vim.keymap.set('n', keys, mapping, { noremap = true, buffer = bufnr })
    end

    bmap(',gD', vim.lsp.buf.declaration)
    bmap(',gd', vim.lsp.buf.definition)
    bmap(',gi', vim.lsp.buf.implementation)
    bmap(',gr', vim.lsp.buf.references)
    bmap(',h', vim.lsp.buf.hover)
    bmap(',sg', vim.lsp.buf.signature_help)
    bmap(',td', vim.lsp.buf.type_definition)
    bmap(',rn', vim.lsp.buf.rename)
    bmap(',ca', vim.lsp.buf.code_action)
    bmap(',f', function() vim.lsp.buf.format { async = true } end)
    bmap(',wa', vim.lsp.buf.add_workspace_folder)
    bmap(',wr', vim.lsp.buf.remove_workspace_folder)
    bmap(',wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end)
  end

  -- map <Leader>, back to , for actual , usage
  map.nmap('<Leader>,', ',')

  -- setup lsps
  local lspconfig = require 'lspconfig'
  lspconfig.sumneko_lua.setup {
    settings = {
      Lua = {
        workspace = {
          library = vim.api.nvim_get_runtime_file('', true),
        },
      },
    },
    on_attach = on_attach,
  }
  local servers = {
    'intelephense',
    'tsserver',
    'csharp_ls',
    'yamlls',
    'jsonls',
  }
  for _, lsp in pairs(servers) do
    lspconfig[lsp].setup { on_attach = on_attach }
  end

  -- setup tools that uses the lsp
  require 'rust-tools'.setup {
    server = {
      on_attach = on_attach,
    },
  }

  require 'flutter-tools'.setup {
    lsp = {
      on_attach = on_attach,
    },
  }
end
