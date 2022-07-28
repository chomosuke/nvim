-- for bootstrap
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins/init.lua source <afile> | PackerSync
  augroup end
]])

return require 'packer'.startup {
  function(use)
    -- for packer to host itself
    use 'wbthomason/packer.nvim'

    require 'plugins.treesitter' (use)
    require 'plugins.lsp-dap' (use)
    require 'plugins.git' (use)
    require 'plugins.autopairs' (use)
    require 'plugins.telescope' (use)
    require 'plugins.statusline' (use)
    require 'plugins.indent' (use)
    require 'plugins.file-tree' (use)
    require 'plugins.navigation' (use)
    require 'plugins.bufferline' (use)
    require 'plugins.themes' (use)

    -- winbar
    use {
      'fgheng/winbar.nvim',
      config = function()
        local default_config = require 'winbar.config'.defaults
        require 'winbar'.setup {
          enabled = true,
          exclude_filetype = require 'util'.table_concat(
            default_config.exclude_filetype,
            {
              'gitcommit',
            }
          ),
        }
      end,
    }

    -- for smooth scrolling
    use {
      'chomosuke/neoscroll.nvim',
      config = function()
        require 'neoscroll'.setup()
      end,
    }

    -- for keybinding hint
    use {
      'folke/which-key.nvim',
      config = function()
        require 'which-key'.setup {}
      end
    }

    -- better escape mapping
    use {
      'max397574/better-escape.nvim',
      config = function()
        require 'better_escape'.setup {
          mapping = { ',.' },
          timeout = 128,
        }
        local map = require 'map'
        map.map(',.', '<Esc>')
        map.cmap(',.', '<Esc>')
        map.tmap(',.', '<C-\\><C-n>')
      end,
    }

    -- for comment toggle
    use {
      'numToStr/Comment.nvim',
      config = function()
        require 'Comment'.setup()
      end
    }

    -- terminal
    use {
      'akinsho/toggleterm.nvim',
      config = function()
        require 'toggleterm'.setup {
          size = 16,
          open_mapping = '<Leader>t',
          start_in_insert = false,
          insert_mappings = false,
          terminal_mappings = false,
        }
      end,
    }

    -- markdown preview
    use {
      'iamcco/markdown-preview.nvim',
      run = function() vim.fn['mkdp#util#install']() end,
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
      require 'packer'.sync()
    end
  end,
  config = {
    profile = {
      enable = true,
    },
  },
}
