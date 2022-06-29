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

-- for auto PackerSync
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

return require 'packer'.startup {
  function(use)
    -- for packer to host itself
    use 'wbthomason/packer.nvim'

    -- syntax highlighting and many more
    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = function()
        require 'nvim-treesitter.install'.compilers = { 'clang' }
        require 'nvim-treesitter.configs'.setup {
          highlight = {
            enable = true,
          },
          rainbow = {
            enable = true,
          },
        }
      end,
    }
    -- bracket coloring
    use 'p00f/nvim-ts-rainbow'

    -- for git
    use {
      'lewis6991/gitsigns.nvim',
      config = require 'plugins_config.gitsigns',
    }
    use 'tpope/vim-fugitive'

    -- for language servers
    use 'williamboman/nvim-lsp-installer'
    use {
      'neovim/nvim-lspconfig',
      config = require 'plugins_config.nvim-lspconfig',
    }
    use 'tamago324/nlsp-settings.nvim'
    use {
      'simrat39/rust-tools.nvim',
      requires = 'nvim-lua/plenary.nvim',
    }
    use {
      'akinsho/flutter-tools.nvim',
      requires = 'nvim-lua/plenary.nvim',
    }
    use {
      'ms-jpq/coq_nvim',
      branch = 'coq',
      requires = {
        { 'ms-jpq/coq.artifacts', branch = 'artifacts' },
        { 'ms-jpq/coq.thirdparty', branch = '3p' },
      },
      config = function()
        vim.g.coq_settings = {
          auto_start = true,
          display = {
            icons = {
              mode = 'short',
            },
          },
          limits = {
            completion_auto_timeout = 1,
            completion_manual_timeout = 5,
          }
        }
        require 'coq'
      end,
    }

    -- for autopairs
    use {
      'windwp/nvim-autopairs',
      config = require 'plugins_config.nvim-autopairs',
    }

    -- for indentation
    use {
      'nmac427/guess-indent.nvim',
      config = function()
        require 'guess-indent'.setup {}
      end,
    }

    -- for telescope finding files
    use {
      'nvim-telescope/telescope.nvim',
      config = require 'plugins_config.telescope',
      requires = {
        'nvim-lua/plenary.nvim',
        {
          'nvim-telescope/telescope-fzf-native.nvim',
          run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
        },
      },
    }

    -- for statusline
    use {
      'nvim-lualine/lualine.nvim',
      requires = {
        'kyazdani42/nvim-web-devicons',
        'arkav/lualine-lsp-progress',
      },
      config = require 'plugins_config.lualine',
    }

    -- for indentation guides
    use {
      'lukas-reineke/indent-blankline.nvim',
      config = require 'plugins_config.indent-blankline',
    }

    -- for theme
    use {
      'Mofiqul/vscode.nvim',
      config = function()
        vim.g.vscode_italic_comment = 1
        vim.g.vscode_disable_nvimtree_bg = true
      end,
    }
    use 'rmehri01/onenord.nvim'
    use 'navarasu/onedark.nvim'
    use 'marko-cerovac/material.nvim'
    use {
      'sainnhe/gruvbox-material',
      config = function()
        vim.gruvbox_material_enable_italic = 1
      end,
    }
    use 'projekt0n/github-nvim-theme'

    -- for file explorer
    use {
      'kyazdani42/nvim-tree.lua',
      requires = 'kyazdani42/nvim-web-devicons', -- for file icon
      config = require 'plugins_config.nvim-tree',
    }

    -- for smooth scrolling
    use {
      'chomosuke/neoscroll.nvim',
      config = function()
        require 'neoscroll'.setup()
      end,
    }

    -- for buffer as tabs
    use {
      'akinsho/bufferline.nvim',
      tag = 'v2.*',
      requires = 'kyazdani42/nvim-web-devicons',
      config = require 'plugins_config.bufferline',
    }

    -- for keybinding hint
    use {
      'folke/which-key.nvim',
      config = function()
        require('which-key').setup {}
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

    -- navigation
    use {
      'ggandor/leap.nvim',
      config = function()
        require 'leap'.set_default_keymaps()
      end
    }
    use {
      'ziontee113/syntax-tree-surfer',
      config = require 'plugins_config.syntax-tree-surfer',
    }

    -- for comment toggle
    use {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup()
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
