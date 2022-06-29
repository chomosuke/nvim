local map = require 'map'

-- map space to leader
vim.g.mapleader = ' '

-- scroll faster
map.nmap('<C-e>', '8<C-e>')
map.nmap('<C-y>', '8<C-y>')

-- mappings for navigating splits
map.nmap('<Leader>h', '<C-w><C-h>')
map.nmap('<Leader>j', '<C-w><C-j>')
map.nmap('<Leader>k', '<C-w><C-k>')
map.nmap('<Leader>l', '<C-w><C-l>')

-- mappings for refresh after open fold
map.map('zo', 'zo<cmd>IndentBlanklineRefresh<CR>')
map.map('zO', 'zO<cmd>IndentBlanklineRefresh<CR>')
map.map('zc', 'zc<cmd>IndentBlanklineRefresh<CR>')
map.map('zC', 'zC<cmd>IndentBlanklineRefresh<CR>')
map.map('za', 'za<cmd>IndentBlanklineRefresh<CR>')
map.map('zA', 'zA<cmd>IndentBlanklineRefresh<CR>')
map.map('zv', 'zv<cmd>IndentBlanklineRefresh<CR>')
map.map('zx', 'zx<cmd>IndentBlanklineRefresh<CR>')
map.map('zX', 'zX<cmd>IndentBlanklineRefresh<CR>')
map.map('zm', 'zm<cmd>IndentBlanklineRefresh<CR>')
map.map('zM', 'zM<cmd>IndentBlanklineRefresh<CR>')
map.map('zr', 'zr<cmd>IndentBlanklineRefresh<CR>')
map.map('zR', 'zR<cmd>IndentBlanklineRefresh<CR>')
map.map('zn', 'zn<cmd>IndentBlanklineRefresh<CR>')
map.map('zN', 'zN<cmd>IndentBlanklineRefresh<CR>')
map.map('zi', 'zi<cmd>IndentBlanklineRefresh<CR>')
