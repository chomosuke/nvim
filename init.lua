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

-- for large files
vim.opt.redrawtime = 20000
vim.opt.maxmempattern = 200000

-- for packer
require 'plugins'

-- for lsp
local lspconfig = require 'lspconfig'
lspconfig.rust_analyzer.setup {
  settings = {
    ['rust-analyzer'] = {
      checkOnSave = {
        command = 'clippy',
      },
    },
  },
}
lspconfig.sumneko_lua.setup {}
lspconfig.quick_lint_js.setup {}

