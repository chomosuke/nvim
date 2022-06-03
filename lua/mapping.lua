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

-- all modes exept insert
local function noimap(keys, mapping)
  keymap('', keys, mapping)
  keymap('t', keys, mapping)
  keymap('c', keys, mapping)
end

local function imap(keys, mapping)
  keymap('i', keys, mapping)
end

local function nmap(keys, mapping)
  keymap('n', keys, mapping)
end

-- map space to leader
vim.g.mapleader = ' '

-- map ,. to <Esc> except insert cause that's handled by better escape
noimap(',.', '<Esc>')
-- map <Leader>, back to , for actual , usage
nmap('<Leader>,', ',')

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
nmap('gt', ':BufferLineCycleNext<CR>')
nmap('gT', ':BufferLineCyclePrev<CR>')
nmap('][', ':BufferLineMoveNext<CR>')
nmap('[]', ':BufferLineMovePrev<CR>')
nmap('<Leader>bp', ':BufferLinePick<CR>')
nmap('<Leader>bcp', ':BufferLinePickClose<CR>')
nmap('<Leader>bcl', ':BufferLineCloseLeft<CR>')
nmap('<Leader>bcr', ':BufferLineCloseRight<CR>')
