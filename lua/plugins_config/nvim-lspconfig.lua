return function()
  require 'nvim-lsp-installer'.setup {
    automatic_installation = { exclude = { 'rust_analyzer' } },
  }

  local function map(keys, mapping)
    vim.keymap.set('n', keys, mapping, { noremap = true })
  end

  map(',df', vim.diagnostic.open_float)
  map(',dp', vim.diagnostic.goto_prev)
  map(',dn', vim.diagnostic.goto_next)
  map(',dl', vim.diagnostic.setloclist)

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

  local lspconfig = require 'lspconfig'
  lspconfig.sumneko_lua.setup {
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        },
        diagnostic = {
          globals = { 'vim' },
        },
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
    'eslint',
    'csharp_ls',
  }
  for _, lsp in pairs(servers) do
    lspconfig[lsp].setup { on_attach = on_attach }
  end

  require 'rust-tools'.setup {
    server = {
      settings = {
        ['rust-analyzer'] = {
          checkOnSave = {
            command = 'clippy',
          },
        },
      },
      on_attach = on_attach,
    },
  }
end
