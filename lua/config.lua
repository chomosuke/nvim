local util = require 'util'

-- no mouse
vim.opt.mouse = nil

-- render space & tabs
vim.opt.list = true
vim.opt.listchars = 'tab: ,trail:·,nbsp:⍽'

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

-- don't let cursor go to the top or bottom
vim.opt.scrolloff = 8

-- narrower tab
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- blink cursor after 5 seconds
vim.opt.guicursor =
  'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,a:blinkwait5000-blinkoff500-blinkon500'

-- fold via indent
vim.opt.foldmethod = 'indent'
-- foldlevel 99 to prevent folding on open file.
-- how many time do you use zm anyways.
vim.opt.foldlevel = 99

-- diagnostics gutter icons
local signs = {
  Error = ' ',
  Warn = ' ',
  Hint = ' ',
  Info = ' ',
}
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl })
end

-- default .tex is latex
vim.g.tex_flavor = 'latex'

-- default fileformat is unix
vim.opt.fileformats = 'unix,dos'

-- default colorscheme if plugin is installed
if util.is_module_available 'onedark' then
  require('onedark').load()
end

-- alway show signs to stop it jumping around
vim.opt.signcolumn = 'yes'

-- don't add eol to the last line
vim.opt.fixendofline = false

-- set title to cwd always
vim.opt.title = true
local titlestring = vim.fn.expand '%:p:t'
if titlestring == '' then
  titlestring = vim.fn.expand '%:p:h:t'
end
if titlestring == '' then
  titlestring = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
end
vim.opt.titlestring = titlestring
util.create_autocmds('set_title_to_cwd', {
  {
    event = 'DirChanged',
    opts = {
      callback = function()
        vim.opt.titlestring = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
      end,
    },
  },
})

-- for neovide
-- vim.g.neovide_scroll_animation_length = 3
vim.g.neovide_cursor_animation_length = 0.025
vim.g.neovide_cursor_trail_length = 1
vim.g.neovide_floating_blur_amount_x = 0
vim.g.neovide_floating_blur_amount_y = 0
vim.g.neovide_underline_automatic_scaling = true
