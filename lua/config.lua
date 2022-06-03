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
vim.opt.timeoutlen = 256

-- don't let cursor go to the top or bottom
vim.opt.scrolloff = 8

-- for neovide
vim.g.neovide_cursor_animation_length = 0.025
vim.g.neovide_floating_opacity = 0.8
vim.g.neovide_scroll_animation_length = 0.4
