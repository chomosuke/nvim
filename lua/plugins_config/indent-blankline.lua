return function()
  require 'indent_blankline'.setup {
    use_treesitter = true,
    show_current_context = true,
    use_treesitter_scope = true,
    show_trailing_blankline_indent = false,
  }

  require 'indent_blankline.utils'.reset_highlights()

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

  local highlight_group = vim.fn.synIDtrans(vim.fn.hlID 'IndentBlanklineChar')
  local highlight = {
    vim.fn.synIDattr(highlight_group, "fg", "gui"),
    vim.fn.synIDattr(highlight_group, "fg", "cterm"),
  }

  for i = 1, #highlight do
    if highlight[i] == '' then
      highlight[i] = 'NONE'
    else
      highlight[i] = string.sub(highlight[i], 2, 7)
      highlight[i] = fromhex(highlight[i])
      for j = 1, #highlight[i] do
        highlight[i][j] = math.min(math.floor(highlight[i][j] * 1.6), 255)
      end
      highlight[i] = '#' .. tohex(highlight[i])
    end
  end

  print(highlight[1])

  vim.cmd(
    string.format(
      "highlight IndentBlanklineContextChar guifg=%s ctermfg=%s gui=nocombine cterm=nocombine",
      highlight[1],
      highlight[2]
    )
  )
end
