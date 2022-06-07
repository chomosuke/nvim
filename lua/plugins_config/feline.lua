return function()
  require 'feline'.setup { components = {
      active = {
        {
          {
            provider = '▊ ',
            hl = {
              fg = 'skyblue',
            },
          },
          {
            provider = 'vi_mode',
            hl = function()
              return {
                name = require 'feline.providers.vi_mode'.get_mode_highlight_name(),
                fg = require 'feline.providers.vi_mode'.get_mode_color(),
                style = 'bold',
              }
            end,
          },
          {
            provider = 'file_info',
            hl = {
              fg = 'white',
              bg = 'oceanblue',
              style = 'bold',
            },
            left_sep = {
              'slant_left_2',
              { str = ' ', hl = { bg = 'oceanblue', fg = 'NONE' } },
            },
            right_sep = {
              { str = ' ', hl = { bg = 'oceanblue', fg = 'NONE' } },
              'slant_right_2',
              ' ',
            },
          },
          {
            provider = 'diagnostic_errors',
            hl = { fg = 'red' },
          },
          {
            provider = 'diagnostic_warnings',
            hl = { fg = 'yellow' },
          },
          {
            provider = 'diagnostic_hints',
            hl = { fg = 'cyan' },
          },
          {
            provider = 'diagnostic_info',
            hl = { fg = 'skyblue' },
          },
        },
        {
          {
            provider = 'git_branch',
            hl = {
              fg = 'white',
              bg = 'black',
              style = 'bold',
            },
            right_sep = {
              str = ' ',
              hl = {
                fg = 'NONE',
                bg = 'black',
              },
            },
          },
          {
            provider = 'git_diff_added',
            hl = {
              fg = 'green',
              bg = 'black',
            },
          },
          {
            provider = 'git_diff_changed',
            hl = {
              fg = 'orange',
              bg = 'black',
            },
          },
          {
            provider = 'git_diff_removed',
            hl = {
              fg = 'red',
              bg = 'black',
            },
            right_sep = {
              str = ' ',
              hl = {
                fg = 'NONE',
                bg = 'black',
              },
            },
          },
          {
            provider = 'line_percentage',
            hl = {
              style = 'bold',
            },
            left_sep = '  ',
            right_sep = ' ',
          },
        }
      },
      inactive = {
        {
          {
            provider = 'file_type',
            hl = {
              fg = 'white',
              bg = 'oceanblue',
              style = 'bold',
            },
            left_sep = {
              str = ' ',
              hl = {
                fg = 'NONE',
                bg = 'oceanblue',
              },
            },
            right_sep = {
              {
                str = ' ',
                hl = {
                  fg = 'NONE',
                  bg = 'oceanblue',
                },
              },
              'slant_right',
            },
          },
          -- Empty component to fix the highlight till the end of the statusline
          {},
        }
      },
    },
  }
end
