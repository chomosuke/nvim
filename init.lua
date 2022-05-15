-- helpers for keymap
function map(mode, keys, mapping)
	vim.api.nvim_set_keymap(mode, keys, mapping, { noremap = true })
end

function imap(keys, mapping)
	map('i', keys, mapping)
end

function nmap(keys, mapping)
	map('n', keys, mapping)
end

-- map shift-enter & shift-space to <Esc>
imap('<S-CR>', '<Esc>')
imap('<S-Space>', '<Esc>')

-- show trailing white space & tabs
vim.opt.list = true

-- show relative line numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- for packer
require('plugins')
