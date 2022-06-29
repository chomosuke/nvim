return {
  sumneko_lua = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostic = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
      },
    },
  },
}
