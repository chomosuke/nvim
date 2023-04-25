local util = require 'util'

-- normally timeout after 256 but in insert have faster timeout.
vim.opt.timeoutlen = 256
util.create_autocmds('change_timeoutlen_upon_insert', {
  {
    event = 'InsertEnter',
    opts = {
      callback = function()
        vim.opt.timeoutlen = 128
      end,
    },
  },
  {
    event = 'InsertLeave',
    opts = {
      callback = function()
        vim.opt.timeoutlen = 256
      end,
    },
  },
})

-- map ,. to Esc
util.imap(',.', '<Esc>')
util.map(',.', '<Esc>')
util.smap(',.', '<Esc>')
util.cmap(',.', '<Esc>')
util.tmap(',.', '<C-\\><C-n>')

-- map space to leader
vim.g.mapleader = ' '

-- scroll faster
util.nmap('<C-e>', '8<C-e>')
util.nmap('<C-y>', '8<C-y>')

-- mappings for navigating splits
util.nmap('<leader>h', '<C-w><C-h>')
util.nmap('<leader>j', '<C-w><C-j>')
util.nmap('<leader>k', '<C-w><C-k>')
util.nmap('<leader>l', '<C-w><C-l>')

-- mappings for refresh after open fold
util.nmap('zo', 'zo<cmd>IndentBlanklineRefresh<CR>')
util.nmap('zO', 'zO<cmd>IndentBlanklineRefresh<CR>')
util.nmap('zc', 'zc<cmd>IndentBlanklineRefresh<CR>')
util.nmap('zC', 'zC<cmd>IndentBlanklineRefresh<CR>')
util.nmap('za', 'za<cmd>IndentBlanklineRefresh<CR>')
util.nmap('zA', 'zA<cmd>IndentBlanklineRefresh<CR>')
util.nmap('zv', 'zv<cmd>IndentBlanklineRefresh<CR>')
util.nmap('zx', 'zx<cmd>IndentBlanklineRefresh<CR>')
util.nmap('zX', 'zX<cmd>IndentBlanklineRefresh<CR>')
util.nmap('zm', 'zm<cmd>IndentBlanklineRefresh<CR>')
util.nmap('zM', 'zM<cmd>IndentBlanklineRefresh<CR>')
util.nmap('zr', 'zr<cmd>IndentBlanklineRefresh<CR>')
util.nmap('zR', 'zR<cmd>IndentBlanklineRefresh<CR>')
util.nmap('zn', 'zn<cmd>IndentBlanklineRefresh<CR>')
util.nmap('zN', 'zN<cmd>IndentBlanklineRefresh<CR>')
util.nmap('zi', 'zi<cmd>IndentBlanklineRefresh<CR>')

-- force close current tab
util.nmap('<leader>bf', '<cmd>bd!<CR>')

-- don't yank pasted over content
util.vmap('p', '"_dP')
