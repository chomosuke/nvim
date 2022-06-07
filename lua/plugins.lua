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

return require 'packer'.startup({
  function(use)
    -- for packer to host itself
    use 'wbthomason/packer.nvim'

    -- prereq for many plugins
    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = function()
        require 'nvim-treesitter.configs'.setup {
          highlight = {
            enable = true,
          },
        }
      end,
    }

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
    use {
      'simrat39/rust-tools.nvim',
      config = require 'rust-tools'.setup {}
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
        }
        require 'coq'
      end,
    }

    -- for autopairs
    use {
      'windwp/nvim-autopairs',
      config = require 'plugins_config/nvim-autopairs',
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
      requires = 'nvim-lua/plenary.nvim',
    }

    -- for statusline
    use {
      'nvim-lualine/lualine.nvim',
      requires = {
        'kyazdani42/nvim-web-devicons',
        'arkav/lualine-lsp-progress',
      },
      config = require 'plugins_config/lualine',
    }
    -- use {
    --   'feline-nvim/feline.nvim',
    --   config = require 'plugins_config.feline',
    -- }

    -- for indentation guides
    use {
      'lukas-reineke/indent-blankline.nvim',
      config = function()
        require 'indent_blankline'.setup {}
      end,
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

    -- -- for smooth scrolling
    -- use {
    --   'karb94/neoscroll.nvim',
    --   config = function()
    --     require 'neoscroll'.setup()
    --   end,
    -- }

    -- for buffer as tabs
    use {
      'akinsho/bufferline.nvim',
      tag = 'v2.*',
      requires = 'kyazdani42/nvim-web-devicons',
      config = function()
        require 'bufferline'.setup {
          options = {
            numbers = function(opts)
              return string.format('%s', opts.id)
            end,
            close_command = 'bdelete %d',
            max_name_length = 50,
            max_prefix_length = 30,
            offsets = { { filetype = 'NvimTree', text = 'File Explorer', text_align = 'left' } },
            show_buffer_close_icons = false,
            show_close_icon = false,
            diagnostics = 'nvim_lsp',
            diagnostics_indicator = function(count, level, diagnostics_dict, context)
              local icon = level:match 'error' and '' or level:match 'warning' and '' or level:match 'info' and '' or level:match 'hint' and '' or '?'
              return icon
            end,
          },
        }
      end,
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
      end,
    }

    -- hop navigation
    use {
      'phaazon/hop.nvim',
      config = function()
        require 'hop'.setup { keys = 'aoeuhtnsidpgcrlyfqjkmwvzxb' }
      end
    }

    -- dashboard
    use {
      'glepnir/dashboard-nvim',
      config = require 'plugins_config.dashboard',
    }

    -- for comment toggle
    use {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup()
      end
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
      require 'packer'.sync()
    end
  end,
  config = {
    display = {
      open_fn = require('packer.util').float,
    },
    profile = {
      enable = true,
    },
  },
})
