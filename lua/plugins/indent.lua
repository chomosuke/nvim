return {
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'VimEnter', -- for calculating highlight color based on colorscheme
    config = function()
      --   helper functions definition   --
      local function fromhex(str)
        local chars = str:gsub('..', function(cc)
          return string.char(tonumber(cc, 16))
        end)

        local nums = {}
        for i = 1, #chars do
          nums[i] = string.byte(chars, i)
        end

        return nums
      end

      local function tohex(nums)
        local chars = ''
        for i = 1, #nums do
          chars = chars .. string.char(nums[i])
        end

        return (
          chars:gsub('.', function(c)
            return string.format('%02X', string.byte(c))
          end)
        )
      end

      local function set_highlight(highlight_name1, highlight_name2, diff_func)
        local highlight_group = vim.fn.synIDtrans(vim.fn.hlID 'Normal')
        local highlight = {
          vim.fn.synIDattr(highlight_group, 'bg', 'gui'),
          vim.fn.synIDattr(highlight_group, 'bg', 'cterm'),
        }

        for i = 1, #highlight do
          if highlight[i] == '' then
            highlight[i] = 'NONE'
          end
        end

        vim.cmd(
          string.format(
            'highlight %s guibg=%s ctermbg=%s gui=nocombine cterm=nocombine',
            highlight_name1,
            highlight[1],
            highlight[2]
          )
        )

        for i = 1, #highlight do
          if highlight[i] ~= 'NONE' then
            highlight[i] = string.sub(highlight[i], 2, 7)
            ---@diagnostic disable-next-line: assign-type-mismatch
            highlight[i] = fromhex(highlight[i])
            for j = 1, #highlight[i] do
              highlight[i][j] = diff_func(highlight[i][j])
            end
            highlight[i] = '#' .. tohex(highlight[i])
          end
        end

        vim.cmd(
          string.format(
            'highlight %s guibg=%s ctermbg=%s gui=nocombine cterm=nocombine',
            highlight_name2,
            highlight[1],
            highlight[2]
          )
        )
      end
      -- helper functions definition end --

      local name1 = 'IndentBlankline1'
      local name2 = 'IndentBlankline2'
      set_highlight(name1, name2, function(hi)
        return math.max(hi - 6, 0)
      end)

      require('indent_blankline').setup {
        use_treesitter = true,
        show_trailing_blankline_indent = false,
        char = '',
        char_highlight_list = {
          name1,
          name2,
        },
        space_char_highlight_list = {
          name1,
          name2,
        },
        filetype_exclude = {
          'lspinfo',
          'packer',
          'checkhealth',
          'help',
          'man',
          '',
          'clojure',
        },
      }
    end,
  },

  {
    'nmac427/guess-indent.nvim',
    config = function()
      require('guess-indent').setup {
        filetype_exclude = {
          'netrw',
          'tutor',
          'clojure',
        },
      }

      require('util').create_autocmds('set_indent_to_2_for_clojure', {
        {
          'FileType',
          {
            pattern = 'clojure',
            command = 'setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2',
          },
        },
      })
    end,
  },
}
