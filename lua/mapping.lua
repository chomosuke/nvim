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

-- mappings for telescope
nmap('<Leader>fd', ':Telescope fd<CR>')
nmap('<Leader>cb', ':Telescope current_buffer_fuzzy_find<CR>')

-- mappings for NvimTree
nmap('<Leader>n', ':NvimTreeToggle<CR>')
nmap('<Leader>r', ':NvimTreeRefresh<CR>')

-- mappings for navigating splits
nmap('<Leader>h', '<C-w><C-h>')
nmap('<Leader>j', '<C-w><C-j>')
nmap('<Leader>k', '<C-w><C-k>')
nmap('<Leader>l', '<C-w><C-l>')

-- mappings for bufferline
nmap(']]', ':BufferLineCycleNext<CR>')
nmap('[[', ':BufferLineCyclePrev<CR>')
nmap('][', ':BufferLineMoveNext<CR>')
nmap('[]', ':BufferLineMovePrev<CR>')
nmap('<Leader>bp', ':BufferLinePick<CR>')
nmap('<Leader>bcp', ':BufferLinePickClose<CR>')
nmap('<Leader>bcl', ':BufferLineCloseLeft<CR>')
nmap('<Leader>bcr', ':BufferLineCloseRight<CR>')
