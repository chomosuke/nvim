return function()
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
        local icon = level:match 'error' and '' or level:match 'warning' and '' or level:match 'info' and ''
          or level:match 'hint' and '' or '?'
        return icon
      end,
    },
  }
end
