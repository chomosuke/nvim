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

    require 'plugins.treesitter' (use)
    require 'plugins.lsp-dap' (use)
    require 'plugins.cmp' (use)
    require 'plugins.git' (use)
    require 'plugins.autopairs' (use)
    require 'plugins.telescope' (use)
    require 'plugins.statusline' (use)
    require 'plugins.indent' (use)
    require 'plugins.file-tree' (use)
    require 'plugins.navigation' (use)
    require 'plugins.bufferline' (use)
    require 'plugins.themes' (use)

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
          timeout = 256,
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
          size = 12,
          open_mapping = '<leader>t',
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

    -- competitive programming auto test
    use {
      'xeluxee/competitest.nvim',
      requires = 'MunifTanjim/nui.nvim',
      config = function()
        require 'competitest'.setup {}
      end,
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
