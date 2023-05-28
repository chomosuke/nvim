-- Lazy load via autocmd to avoid weird race condition when lazy = false
require('util').create_autocmds('nvim_tree_open_on_VimEnter', {
  {
    event = 'VimEnter',
    opts = {
      callback = function(data)
        -- buffer is a directory
        local directory = vim.fn.isdirectory(data.file) == 1
        if not directory then
          return
        end
        -- create a new, empty buffer
        vim.cmd.enew()
        -- wipe the directory buffer
        vim.cmd.bw(data.buf)
        -- change to the directory
        vim.cmd.cd(data.file)
        -- open the tree
        require('nvim-tree.api').tree.open()
      end,
    },
  },
})

return {
  {
    'nvim-tree/nvim-tree.lua',
    keys = { '<leader>n', '<leader>r' },
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- for file icon
    config = function()
      -- mapings
      local wk = require 'which-key'
      wk.register {
        ['<leader>'] = {
          n = { '<cmd>NvimTreeToggle<CR>', 'toggle file tree' },
          r = { '<cmd>NvimTreeRefresh<CR>', 'refresh file tree' },
        },
      }

      require('nvim-tree').setup {
        renderer = {
          highlight_opened_files = 'icon',
          full_name = true,
          indent_markers = {
            enable = true,
          },
          icons = {
            show = {
              folder_arrow = false,
            },
            glyphs = {
              modified = '[+]',
            },
          },
        },
        actions = {
          open_file = {
            window_picker = {
              enable = false,
            },
          },
        },
        diagnostics = {
          enable = true,
          icons = {
            hint = '',
            info = '',
            warning = '',
            error = '',
          },
          show_on_dirs = true,
          show_on_open_dirs = false,
        },
        git = {
          ignore = false,
          show_on_dirs = true,
          show_on_open_dirs = false,
        },
        modified = {
          enable = true,
          show_on_dirs = true,
          show_on_open_dirs = false,
        },
      }
    end,
  },
}
