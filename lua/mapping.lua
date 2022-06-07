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

local function map(keys, mapping)
  keymap('', keys, mapping)
end

-- map space to leader
vim.g.mapleader = ' '

-- map ,. to <Esc> except insert cause that's handled by better escape
noimap(',.', '<Esc>')

-- map <Leader>, & <Leader>; back to , & ; for actual , & ; usage
nmap('<Leader>,', ',')
nmap('<Leader>;', ';')

-- mappings for telescope
nmap(';f', '<cmd>Telescope find_files<CR>')
nmap(';c', '<cmd>Telescope current_buffer_fuzzy_find<CR>')
nmap(';d', '<cmd>Telescope live_grep<CR>')
nmap(';u', '<cmd>Telescope grep_string<CR>')
nmap(';gc', '<cmd>Telescope git_commits<CR>')
nmap(';gu', '<cmd>Telescope git_bcommits<CR>')
nmap(';gb', '<cmd>Telescope git_branches<CR>')
nmap(';gs', '<cmd>Telescope git_status<CR>')
nmap(';gh', '<cmd>Telescope git_stash<CR>')
nmap(';lr', '<cmd>Telescope lsp_references<CR>')
nmap(';ld', '<cmd>Telescope diagnostics bufnr=0<CR>')
nmap(';vm', '<cmd>Telescope keymaps<CR>')

-- mappings for NvimTree
nmap('<Leader>n', '<cmd>NvimTreeToggle<CR>')
nmap('<Leader>r', '<cmd>NvimTreeRefresh<CR>')

-- mappings for navigating splits
nmap('<Leader>h', '<C-w><C-h>')
nmap('<Leader>j', '<C-w><C-j>')
nmap('<Leader>k', '<C-w><C-k>')
nmap('<Leader>l', '<C-w><C-l>')

-- mappings for bufferline
nmap(']]', '<cmd>BufferLineCycleNext<CR>')
nmap('[[', '<cmd>BufferLineCyclePrev<CR>')
nmap('<Leader>f', '<cmd>BufferLineCycleNext<CR>')
nmap('<Leader>y', '<cmd>BufferLineCyclePrev<CR>')
nmap('][', '<cmd>BufferLineMoveNext<CR>')
nmap('[]', '<cmd>BufferLineMovePrev<CR>')
nmap('<Leader>bp', '<cmd>BufferLinePick<CR>')
nmap('<Leader>bc', '<cmd>BufferLinePickClose<CR>')
nmap('<Leader>bl', '<cmd>BufferLineCloseLeft<CR>')
nmap('<Leader>br', '<cmd>BufferLineCloseRight<CR>')

-- mappings for hop
map('<Leader>u', '<cmd>HopLine<CR>')
map('<Leader>e', '<cmd>HopWord<CR>')
map('<Leader>o', '<cmd>HopLineStart<CR>')
map('<Leader>a', '<cmd>HopChar2<CR>')
map('<Leader>c', '<cmd>HopChar1<CR>')

-- mappings for dashboard
nmap('<Leader>ds', '<cmd>SessionSave<CR>')
nmap('<Leader>dl', '<cmd>SessionLoad<CR>')
nmap('<Leader>dh', '<cmd>DashboardFindHistory<CR>')
nmap('<Leader>dc', '<cmd>DashboardChangeColorscheme<CR>')
nmap('<Leader>db', '<cmd>DashboardJumpMark<CR>')
nmap('<Leader>dn', '<cmd>DashboardNewFile<CR>')
