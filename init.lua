-- helpers for keymap
local function map(mode, keys, mapping)
  vim.api.nvim_set_keymap(mode, keys, mapping, { noremap = true })
end

local function imap(keys, mapping)
  map('i', keys, mapping)
end

local function nmap(keys, mapping)
  map('n', keys, mapping)
end

-- map shift-enter & shift-space to <Esc>
imap('<S-CR>', '<Esc>')

-- show trailing white space & tabs
vim.opt.list = true

-- show relative line numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- for packer
require 'plugins'

-- for lsp
local lsp_status = require 'lsp-status'
lsp_status.register_progress()

local lspconfig = require 'lspconfig'

vim.cmd [[
  autocmd BufEnter * lua require 'completion'.on_attach()
]]

local function on_attach(client)
  lsp_status.on_attach(client)
end

local capabilities = lsp_status.capabilities

lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ['rust-analyzer'] = {
      checkOnSave = {
        command = 'clippy',
      },
    },
  },
}
lspconfig.sumneko_lua.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lsp_status.status()

-- for rust tools
require 'rust-tools'.setup {}

