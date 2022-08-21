return function(use)
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
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

        return (chars:gsub('.', function(c)
          return string.format('%02X', string.byte(c))
        end))
      end

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
          'highlight IndentBlanklineIndent1 guibg=%s ctermbg=%s gui=nocombine cterm=nocombine',
          highlight[1],
          highlight[2]
        )
      )

      for i = 1, #highlight do
        if highlight[i] ~= 'NONE' then
          highlight[i] = string.sub(highlight[i], 2, 7)
          highlight[i] = fromhex(highlight[i])
          for j = 1, #highlight[i] do
            highlight[i][j] = math.floor(highlight[i][j] * 0.88)
          end
          highlight[i] = '#' .. tohex(highlight[i])
        end
      end

      vim.cmd(
        string.format(
          'highlight IndentBlanklineIndent2 guibg=%s ctermbg=%s gui=nocombine cterm=nocombine',
          highlight[1],
          highlight[2]
        )
      )

      require 'indent_blankline'.setup {
        use_treesitter = true,
        show_trailing_blankline_indent = false,
        char = '',
        char_highlight_list = {
          "IndentBlanklineIndent1",
          "IndentBlanklineIndent2",
        },
        space_char_highlight_list = {
          "IndentBlanklineIndent1",
          "IndentBlanklineIndent2",
        },
      }
    end,
  }

  use {
    'nmac427/guess-indent.nvim',
    config = function()
      require 'guess-indent'.setup {}
    end,
  }
end
