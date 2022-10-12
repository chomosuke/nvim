-- for bootstrap
local fn = vim.fn
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PackerBootstrap = fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
end

return require 'packer'.startup {
  function(use)
    -- for packer to host itself
    use 'wbthomason/packer.nvim'

    require 'plugins.autopairs' (use)
    require 'plugins.bufferline' (use)
    require 'plugins.cmp' (use)
    require 'plugins.file-tree' (use)
    require 'plugins.git' (use)
    require 'plugins.indent' (use)
    require 'plugins.lsp-dap' (use)
    require 'plugins.navigation' (use)
    require 'plugins.statusline' (use)
    require 'plugins.telescope' (use)
    require 'plugins.themes' (use)
    require 'plugins.treesitter' (use)

    -- scrollbar
    use {
      'dstein64/nvim-scrollview',
      config = function()
        require 'scrollview'.setup {
          column = 1,
          winblend = 80,
        }
        vim.cmd 'highlight ScrollView guibg=#ffffff'
      end,
    }

    -- marks
    use {
      'chentoast/marks.nvim',
      config = function()
        require 'marks'.setup {}
      end,
    }

    -- competitive programming auto test
    use {
      'xeluxee/competitest.nvim',
      requires = 'MunifTanjim/nui.nvim',
      config = function()
        require 'competitest'.setup {}
      end,
    }

    -- spell check
    use {
      'lewis6991/spellsitter.nvim',
      config = function()
        require 'util'.create_autocmds(
          'set_spell_for_spell_check',
          { { 'Filetype', {
            callback = function() vim.opt.spell = true end,
            pattern = {
              'gitcommit',
            },
          } } }
        )
        require 'spellsitter'.setup()
      end,
    }

    -- auto save latex files to trigger recompile
    use {
      'Pocco81/auto-save.nvim',
      config = function()
        require 'auto-save'.setup {
          condition = function(buf)
            if vim.fn.getbufvar(buf, '&modifiable') == 1 and
                vim.fn.getbufvar(buf, '&filetype') == 'tex' then
              return true
            end
            return false
          end,
        }
      end,
    }

    -- interactive development
    use {
      'Olical/conjure',
      config = function()
        vim.g['conjure#mapping#prefix'] = '<leader>c'
        vim.g['conjure#filetypes'] = { 'clojure' }
      end,
    }

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

    -- smooth scrolling
    use {
      'chomosuke/neoscroll.nvim',
      config = function()
        if vim.g.neovide == nil then
          require 'neoscroll'.setup()
        end
      end,
    }

    -- markdown preview
    use {
      'iamcco/markdown-preview.nvim',
      run = function() vim.fn['mkdp#util#install']() end,
      config = function()
        vim.g.mkdp_auto_close = 0
      end,
    }

    -- terminal
    use {
      'akinsho/toggleterm.nvim',
      config = function()
        require 'toggleterm'.setup {
          size = 12,
          open_mapping = '<leader>t',
          start_in_insert = false,
          insert_mappings = false,
          terminal_mappings = false,
        }
      end,
    }

    -- for comment toggle
    use {
      'numToStr/Comment.nvim',
      config = function()
        require 'Comment'.setup()
      end
    }

    -- -- better escape mapping
    -- use {
    --   'max397574/better-escape.nvim',
    --   config = function()
    --     require 'better_escape'.setup {
    --       mapping = { ',.' },
    --       timeout = 256,
    --     }
    --     local map = require 'map'
    --     map.map(',.', '<Esc>')
    --     map.cmap(',.', '<Esc>')
    --     map.tmap(',.', '<C-\\><C-n>')
    --   end,
    -- }

    -- for keybinding hint
    use {
      'folke/which-key.nvim',
      config = function()
        local wk = require 'which-key'
        wk.setup {}
        -- suppress ,. escape key mapping
        wk.register({ [',.'] = 'which_key_ignore' }, { mode = 'n' })
        wk.register({ [',.'] = 'which_key_ignore' }, { mode = 'i' })
        wk.register({ [',.'] = 'which_key_ignore' }, { mode = 'c' })
        wk.register({ [',.'] = 'which_key_ignore' }, { mode = 'x' })
        wk.register({ [',.'] = 'which_key_ignore' }, { mode = 's' })
        wk.register({ [',.'] = 'which_key_ignore' }, { mode = 'o' })
        wk.register({ [',.'] = 'which_key_ignore' }, { mode = 't' })
      end
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PackerBootstrap then
      require 'packer'.sync()
    end
  end,
  config = {
    profile = {
      enable = true,
    },
  },
}
