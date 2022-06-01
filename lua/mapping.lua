-- helpers for keymap
local function keymap(mode, keys, mapping)
  vim.api.nvim_set_keymap(mode, keys, mapping, { noremap = true })
end

-- for all modes
local function amap(keys, mapping)
  keymap('', keys, mapping)
  keymap('!', keys, mapping)
  keymap('t', keys, mapping)
end

local function imap(keys, mapping)
  keymap('i', keys, mapping)
end

local function nmap(keys, mapping)
  keymap('n', keys, mapping)
end

-- map shift-enter to <Esc>
amap('<S-CR>', '<Esc>')

-- map space to leader
vim.g.mapleader = ' '

-- map <Leader>fd to open telescope fd
nmap('<Leader>fd', ':Telescope fd<CR>')
nmap('<Leader>cb', ':Telescope current_buffer_fuzzy_find<CR>')

-- mapping for NvimTree
nmap('<Leader>n', ':NvimTreeToggle<CR>')
nmap('<Leader>r', ':NvimTreeRefresh<CR>')

-- mapping for navigating splits
nmap('<Leader>h', '<C-w><C-h>')
nmap('<Leader>j', '<C-w><C-j>')
nmap('<Leader>k', '<C-w><C-k>')
nmap('<Leader>l', '<C-w><C-l>')
