if not vim.g.vscode then
  -- helpers for keymap
  local function map(mode, keys, mapping)
    vim.api.nvim_set_keymap(mode, keys, mapping, { noremap = true })
  end

  local function imap(keys, mapping)
    map('i', keys, mapping)
  end

  local function nmap(keys, mapping)
    map('n', keys, mapping)
  end

  -- helper for require if exist
  function isModuleAvailable(name)
    if package.loaded[name] then
      return true
    else
      for _, searcher in ipairs(package.searchers or package.loaders) do
        local loader = searcher(name)
        if type(loader) == 'function' then
          package.preload[name] = loader
          return true
        end
      end
      return false
    end
  end

  -- map shift-enter & shift-space to <Esc>
  imap('<S-CR>', '<Esc>')

  -- show trailing white space & tabs
  vim.opt.list = true

  -- show relative line numbers
  vim.opt.relativenumber = true
  vim.opt.number = true

  -- for large files
  vim.opt.redrawtime = 20000
  vim.opt.maxmempattern = 200000

  -- for machine specific configuration
  if isModuleAvailable 'machine_specific' then
    require 'machine_specific'
  end

  -- for packer
  require 'plugins'
end
