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

local function cmap(keys, mapping)
  keymap('c', keys, mapping)
end

local function tmap(keys, mapping)
  keymap('t', keys, mapping)
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
map(',.', '<Esc>')
cmap(',.', '<Esc>')
tmap(',.', '<C-\\><C-n>')

-- map <Leader>, & <Leader>; back to , & ; for actual , & ; usage
nmap('<Leader>,', ',')
nmap('<Leader>;', ';')

-- scroll faster
nmap('<C-e>', '8<C-e>')
nmap('<C-y>', '8<C-y>')

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
nmap(';b', '<cmd>Telescope buffers<CR>')

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

-- mappings for refresh after open fold
map('zo', 'zo<cmd>IndentBlanklineRefresh<CR>')
map('zO', 'zO<cmd>IndentBlanklineRefresh<CR>')
map('zc', 'zc<cmd>IndentBlanklineRefresh<CR>')
map('zC', 'zC<cmd>IndentBlanklineRefresh<CR>')
map('za', 'za<cmd>IndentBlanklineRefresh<CR>')
map('zA', 'zA<cmd>IndentBlanklineRefresh<CR>')
map('zv', 'zv<cmd>IndentBlanklineRefresh<CR>')
map('zx', 'zx<cmd>IndentBlanklineRefresh<CR>')
map('zX', 'zX<cmd>IndentBlanklineRefresh<CR>')
map('zm', 'zm<cmd>IndentBlanklineRefresh<CR>')
map('zM', 'zM<cmd>IndentBlanklineRefresh<CR>')
map('zr', 'zr<cmd>IndentBlanklineRefresh<CR>')
map('zR', 'zR<cmd>IndentBlanklineRefresh<CR>')
map('zn', 'zn<cmd>IndentBlanklineRefresh<CR>')
map('zN', 'zN<cmd>IndentBlanklineRefresh<CR>')
map('zi', 'zi<cmd>IndentBlanklineRefresh<CR>')
