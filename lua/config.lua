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

-- narrower tab
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- winbar
vim.opt.winbar = '%f'

-- blink cursor after 5 seconds
vim.opt.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,a:blinkwait5000-blinkoff500-blinkon500'

-- fold via treesitter
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.cmd [[
  augroup open_folds
    autocmd!
    autocmd BufReadPost,FileReadPost * call timer_start(0, { tid -> execute('normal! zR')})  " without delaying 0ms it doesn't work
  augroup end
]]

-- for neovide
vim.g.neovide_cursor_animation_length = 0.025
vim.g.neovide_floating_opacity = 0.8
vim.g.neovide_scroll_animation_length = 0.4
