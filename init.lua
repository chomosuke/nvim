require 'mapping'
require 'plugin-manager'
require 'config'
require('machine-config').on_start()

vim.cmd('helptags ' .. vim.fn.stdpath 'config' .. '/doc/')
