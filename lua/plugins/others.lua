return {
  -- scrollbar
  {
    'dstein64/nvim-scrollview',
    lazy = false,
    config = function()
      require('scrollview').setup {
        column = 1,
        winblend = 80,
      }
      vim.cmd 'highlight ScrollView guibg=#ffffff'
    end,
  },

  -- marks
  {
    'chentoast/marks.nvim',
    event = 'VeryLazy',
    config = function()
      require('marks').setup {}
    end,
  },

  -- spell check
  {
    'lewis6991/spellsitter.nvim',
    ft = 'gitcommit',
    config = function()
      require('util').create_autocmds('set_spell_for_spell_check', {
        {
          event = 'Filetype',
          opts = {
            callback = function()
              vim.opt.spell = true
            end,
            pattern = {
              'gitcommit',
            },
          },
        },
      })
      require('spellsitter').setup()
    end,
  },

  -- auto save latex files to trigger recompile
  {
    'Pocco81/auto-save.nvim',
    ft = 'tex',
    config = function()
      require('auto-save').setup {
        condition = function(buf)
          if
            vim.fn.getbufvar(buf, '&modifiable') == 1
            and vim.fn.getbufvar(buf, '&filetype') == 'tex'
          then
            return true
          end
          return false
        end,
      }
    end,
  },

  -- interactive development
  {
    'Olical/conjure',
    ft = { 'clojure' },
    config = function()
      vim.g['conjure#mapping#prefix'] = '<leader>c'
      vim.g['conjure#filetypes'] = { 'clojure' }
      require('util').create_autocmds('conjure_log_disable', {
        {
          event = 'BufNewFile',
          opts = {
            callback = function()
              vim.diagnostic.disable(0)
            end,
            pattern = {
              'conjure-log-*',
            },
          },
        },
      })
    end,
  },

  -- winbar
  {
    'fgheng/winbar.nvim',
    lazy = false, -- single file start
    config = function()
      local default_config = require('winbar.config').defaults
      require('winbar').setup {
        enabled = true,
        exclude_filetype = require('util').table_concat(
          default_config.exclude_filetype,
          {
            'gitcommit',
          }
        ),
      }
    end,
  },

  -- smooth scrolling
  {
    'karb94/neoscroll.nvim',
    event = 'VeryLazy',
    config = function()
      if vim.g.neovide == nil then
        require('neoscroll').setup()
      end
    end,
  },

  -- markdown preview
  {
    'iamcco/markdown-preview.nvim',
    ft = 'markdown',
    build = function()
      vim.fn['mkdp#util#install']()
    end,
    config = function()
      vim.g.mkdp_auto_close = 0
    end,
  },

  -- for comment toggle
  {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    config = function()
      require('Comment').setup()
    end,
  },

  -- for keybinding hint
  {
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
    end,
  },
}
