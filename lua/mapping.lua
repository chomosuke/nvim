local map = require 'map'
local util = require 'util'

-- normally timeout after 256 but in insert have faster timeout.
vim.opt.timeoutlen = 256
util.create_autocmds(
  'change_timeoutlen_upon_insert',
  {
    { 'InsertEnter', { callback = function() vim.opt.timeoutlen = 128 end } },
    { 'InsertLeave', { callback = function() vim.opt.timeoutlen = 256 end } },
  }
)

-- map ,. to Esc
map.imap(',.', '<Esc>')
map.map(',.', '<Esc>')
map.cmap(',.', '<Esc>')
map.tmap(',.', '<C-\\><C-n>')

-- map space to leader
vim.g.mapleader = ' '

-- scroll faster
map.nmap('<C-e>', '8<C-e>')
map.nmap('<C-y>', '8<C-y>')

-- mappings for navigating splits
map.nmap('<leader>h', '<C-w><C-h>')
map.nmap('<leader>j', '<C-w><C-j>')
map.nmap('<leader>k', '<C-w><C-k>')
map.nmap('<leader>l', '<C-w><C-l>')

-- mappings for refresh after open fold
map.nmap('zo', 'zo<cmd>IndentBlanklineRefresh<CR>')
map.nmap('zO', 'zO<cmd>IndentBlanklineRefresh<CR>')
map.nmap('zc', 'zc<cmd>IndentBlanklineRefresh<CR>')
map.nmap('zC', 'zC<cmd>IndentBlanklineRefresh<CR>')
map.nmap('za', 'za<cmd>IndentBlanklineRefresh<CR>')
map.nmap('zA', 'zA<cmd>IndentBlanklineRefresh<CR>')
map.nmap('zv', 'zv<cmd>IndentBlanklineRefresh<CR>')
map.nmap('zx', 'zx<cmd>IndentBlanklineRefresh<CR>')
map.nmap('zX', 'zX<cmd>IndentBlanklineRefresh<CR>')
map.nmap('zm', 'zm<cmd>IndentBlanklineRefresh<CR>')
map.nmap('zM', 'zM<cmd>IndentBlanklineRefresh<CR>')
map.nmap('zr', 'zr<cmd>IndentBlanklineRefresh<CR>')
map.nmap('zR', 'zR<cmd>IndentBlanklineRefresh<CR>')
map.nmap('zn', 'zn<cmd>IndentBlanklineRefresh<CR>')
map.nmap('zN', 'zN<cmd>IndentBlanklineRefresh<CR>')
map.nmap('zi', 'zi<cmd>IndentBlanklineRefresh<CR>')

-- force close current tab
map.nmap('<leader>bf', '<cmd>bd!<CR>')
