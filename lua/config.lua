-- show trailing white space & tabs
vim.opt.list = true

-- show relative line numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- for large files
vim.opt.redrawtime = 20000
vim.opt.maxmempattern = 200000

-- case insensitive if no uppercase
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- for feline in terminal
vim.opt.termguicolors = true

-- split to right and bottom
vim.opt.splitbelow = true
vim.opt.splitright = true

-- faster timeout
vim.opt.timeoutlen = 512
