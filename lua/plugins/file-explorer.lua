return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",        -- for file icon
    },
    config = function()
      -- mapings
      local wk = require 'which-key'
      wk.add {
        { '<leader>n', '<cmd>Neotree toggle reveal<CR>',           desc = 'tree files' },
        { '<leader>r', '<cmd>Neotree toggle buffers reveal<CR>',   desc = 'tree buffers' },
        { '<leader>s', '<cmd>Neotree toggle document_symbols<CR>', desc = 'tree document_symbols' },
      }

      local function getTelescopeOpts(_state, path)
        return {
          cwd = path,
          search_dirs = { path },
        }
      end

      require 'neo-tree'.setup {
        sources = {
          'filesystem',
          'buffers',
          'document_symbols',
          -- 'neotree-source.iron',
        },
        -- enable_cursor_hijack = true,
        -- hide_root_node = true,            -- Hide the root node.
        open_files_in_last_window = true, -- false = open files in top left window
        source_selector = {
          winbar = true,                  -- toggle to show selector on winbar
          content_layout = 'center',
          sources = {
            { source = 'filesystem' },
            { source = 'buffers' },
            { source = 'document_symbols' },
          },
          truncation_character = "…", -- string
        },
        commands = {
          ---@diagnostic disable-next-line: redundant-parameter
          telescope_find = function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            require('telescope.builtin').find_files(getTelescopeOpts(state, path))
          end,
          ---@diagnostic disable-next-line: redundant-parameter
          telescope_grep = function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            require('telescope.builtin').live_grep(getTelescopeOpts(state, path))
          end,
        },
        filesystem = {
          filtered_items = {
            visible = true,
          },
        },
        buffers = {
          group_empty_dirs = false,
          window = {
            mappings = {
              ['d'] = "buffer_delete",
            },
          },
        },
        document_symbols = {
          follow_cursor = true,
        },
        window = {
          mappings = {
            ['<leader>f'] = 'telescope_find',
            ['<leader>d'] = 'telescope_grep',
            ['<leader>p'] = 'prev_source',
            ['<leader>y'] = 'next_source',
            ['t'] = 'toggle_node',
            ['h'] = function(state)
              local node = state.tree:get_node()
              require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
            end,
            ['gj'] = 'next_git_modified',
            ['gk'] = 'prev_git_modified',
          },
        },
      }
    end,
  },
}
