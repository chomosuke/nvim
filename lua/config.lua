-- no mouse
vim.opt.mouse = nil

-- render space & tabs
vim.opt.list = true
vim.opt.listchars = 'tab: ,trail:·,nbsp:⍽'

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

-- faster timeout for keymaps
vim.opt.timeoutlen = 256

-- don't let cursor go to the top or bottom
vim.opt.scrolloff = 8

-- narrower tab
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- blink cursor after 5 seconds
vim.opt.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,a:blinkwait5000-blinkoff500-blinkon500'

-- fold via treesitter
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
-- foldlevel 99 to prevent newly parsed treesitter nodes to be folded.
-- how many time do you use zm anyways.
vim.opt.foldlevel = 99

-- diagnostics gutter icons
local signs = {
  Error = ' ',
  Warn = ' ',
  Hint = ' ',
  Info = ' '
}
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl })
end

-- default .tex is latex
vim.g.tex_flavor = 'latex'

-- default fileformat is unix
vim.opt.fileformats = 'unix,dos'

-- for neovide
vim.g.neovide_cursor_animation_length = 0.025
vim.g.neovide_cursor_trail_length = 1
vim.g.neovide_floating_opacity = 0.8
vim.g.neovide_scroll_animation_length = 0
