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

-- map space to leader
vim.g.mapleader = ' '

-- map <Leader>fd to open telescope fd
nmap('<Leader>fd', ':Telescope fd<CR>')

-- mapping for NvimTree
nmap('<Leader>n', ':NvimTreeToggle<CR>')
nmap('<Leader>r', ':NvimTreeRefresh<CR>')

-- mapping for navigating splits
nmap('<Leader>h', '<C-w><C-h>')
nmap('<Leader>j', '<C-w><C-j>')
nmap('<Leader>k', '<C-w><C-k>')
nmap('<Leader>l', '<C-w><C-l>')
