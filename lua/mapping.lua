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
nmap('<Leader>ff', ':Telescope find_files<CR>')
nmap('<Leader>fc', ':Telescope current_buffer_fuzzy_find<CR>')
nmap('<Leader>fd', ':Telescope live_grep<CR>')
nmap('<Leader>fu', ':Telescope grep_string<CR>')

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
nmap('<Leader>bc', ':BufferLinePickClose<CR>')
nmap('<Leader>bl', ':BufferLineCloseLeft<CR>')
nmap('<Leader>br', ':BufferLineCloseRight<CR>')

-- mappings for hop
nmap('<Leader>e', ':HopWord<CR>')
nmap('<Leader>u', ':HopLineStart<CR>')

-- mappings for dashboard
nmap('<Leader>ds', ':SessionSave<CR>')
nmap('<Leader>dl', ':SessionLoad<CR>')
nmap('<Leader>dh', ':DashboardFindHistory<CR>')
nmap('<Leader>dc', ':DashboardChangeColorscheme<CR>')
nmap('<Leader>db', ':DashboardJumpMark<CR>')
nmap('<Leader>dn', ':DashboardNewFile<CR>')
