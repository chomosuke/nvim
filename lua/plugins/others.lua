return {
  -- watch files
  {
    'rktjmp/fwatch.nvim',
    event = 'BufRead /Users/rli43/.local/state/nvim/lsp.log',
    config = function()
      local function watch(path)
        require 'fwatch'.watch(path, {
          on_event = function()
            vim.defer_fn(function()
              vim.cmd [[
                edit
                echo 'Refreshed by fwatch'
              ]]
            end, 0)
          end,
        })
      end
      watch('/Users/rli43/.local/state/nvim/lsp.log')
    end,
  },

  -- colorcolumn
  {
    'Bekaboo/deadcolumn.nvim',
    event = 'VeryLazy',
  },

  -- undo
  {
    'mbbill/undotree',
    keys = '<leader>u',
    init = function()
      vim.o.undofile = true
    end,
    config = function()
      local wk = require 'which-key'
      wk.add {
        '<leader>u',
        vim.cmd.UndotreeToggle,
        desc = 'toggle undo tree',
      }
      vim.g.undotree_WindowLayout = 3
      vim.g.undotree_ShortIndicators = 1
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
  },

  -- scrollbar
  {
    'dstein64/nvim-scrollview',
    lazy = false,
    config = function()
      require('scrollview').setup {
        column = 1,
        winblend = 80,
        winblend_gui = 80,
      }
      ---@diagnostic disable-next-line: param-type-mismatch
      vim.defer_fn(function()
        vim.cmd 'highlight ScrollView guibg=#ffffff'
        ---@diagnostic disable-next-line: param-type-mismatch
      end, 0)
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
    ft = { 'clojure', 'python' },
    config = function()
      require('conjure.main').main()
      require('conjure.mapping')['on-filetype']()
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
    init = function()
      vim.g['conjure#mapping#prefix'] = '<leader>c'
      vim.g['conjure#filetypes'] = { 'clojure', 'python' }
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

  -- typst preview
  {
    'chomosuke/typst-preview.nvim',
    ft = 'typst',
    dev = true,
    version = '1.*',
    config = function()
      local tp = require 'typst-preview'
      local wk = require 'which-key'
      wk.add {
        mode = 'n',
        { '<leader>o',  group = 'typst-preview' },
        { '<leader>os', tp.sync_with_cursor,    desc = 'Scroll preview' },
        {
          '<leader>ot',
          function()
            tp.set_follow_cursor(not tp.get_follow_cursor())
          end,
          desc = 'Toggle preview scroll mode',
        },
      }
      require('typst-preview').setup {
        debug = true,
        dependencies_bin = {
          -- ['tinymist'] = 'tinymist',
          -- ['websocat'] = 'websocat',
        },
      }
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
      wk.add {
        ',.',
        hidden = true,
        mode = { 'n', 'i', 'c', 'x', 's', 'o', 't' },
      }
    end,
  },
}
