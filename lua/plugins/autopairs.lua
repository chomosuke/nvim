return {
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      local npairs = require 'nvim-autopairs'

      npairs.setup {
        fast_wrap = {
          map = '<C-e>',
        },
        check_ts = true,
        enable_check_bracket_line = false,
        disable_in_macro = true,
      }

      local Rule = require 'nvim-autopairs.rule'
      npairs.add_rules {
        Rule('\\(', '\\)', 'tex'),
        Rule('$', '$', { 'tex', 'markdown', 'typst' }),
        Rule('\\[', '\\]', 'tex'),
        Rule('\\{', '\\}', 'tex'),
      }
      local cond = require 'nvim-autopairs.conds'
      table.insert(
        npairs.get_rule('`').pair_cond,
        cond.not_filetypes { 'ocaml' }
      )
    end,
  },
}
