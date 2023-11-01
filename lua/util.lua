local M = {}

function M.is_module_available(name)
  if package.loaded[name] then
    return true
  else
    for _, searcher in ipairs(package.loaders) do
      local loader = searcher(name)
      if type(loader) == 'function' then
        package.preload[name] = loader
        return true
      end
    end
    return false
  end
end

---@class AutocmdOpts
---@field pattern? string[]|string
---@field buffer? integer
---@field desc? string
---@field callback? function|string
---@field command? string
---@field once? boolean
---@field nested? boolean

---create autocmds
---@param name string
---@param autocmds { event: string[]|string, opts: AutocmdOpts }[]
function M.create_autocmds(name, autocmds)
  local id = vim.api.nvim_create_augroup(name, {})
  for _, autocmd in ipairs(autocmds) do
    autocmd.opts.group = id
    vim.api.nvim_create_autocmd(autocmd.event, autocmd.opts)
  end
end

function M.table_concat(t1, t2)
  for i = 1, #t2 do
    t1[#t1 + 1] = t2[i]
  end
  return t1
end

function M.is_windows()
  return vim.loop.os_uname().sysname == 'Windows_NT'
end

function M.table_index(table, ...)
  local keys = { ... }
  for _, key in pairs(keys) do
    if type(table) == 'table' then
      table = table[key]
    else
      return table
    end
  end
  return table
end

function M.split(inputstr, sep)
  if sep == nil then
    sep = '%s'
  end
  local t = {}
  for str in string.gmatch(inputstr, '([^' .. sep .. ']+)') do
    table.insert(t, str)
  end
  return t
end

---set textwidth
---@param filetype string
---@param tw integer
function M.set_tw(filetype, tw)
  require('util').create_autocmds('set_tw_for_' .. filetype, {
    {
      event = 'FileType',
      opts = {
        callback = function()
          vim.bo.tw = tw
          vim.cmd('setlocal colorcolumn=' .. (tw + 1))
        end,
        pattern = filetype,
      },
    },
  })
end

-- mapping --

-- for all modes
function M.amap(keys, mapping, opts)
  vim.keymap.set('', keys, mapping, opts)
  vim.keymap.set('!', keys, mapping, opts)
  vim.keymap.set('t', keys, mapping, opts)
end

function M.cmap(keys, mapping, opts)
  vim.keymap.set('c', keys, mapping, opts)
end

function M.tmap(keys, mapping, opts)
  vim.keymap.set('t', keys, mapping, opts)
end

function M.smap(keys, mapping, opts)
  vim.keymap.set('s', keys, mapping, opts)
end

function M.vmap(keys, mapping, opts)
  vim.keymap.set('v', keys, mapping, opts)
end

function M.imap(keys, mapping, opts)
  vim.keymap.set('i', keys, mapping, opts)
end

function M.nmap(keys, mapping, opts)
  vim.keymap.set('n', keys, mapping, opts)
end

function M.map(keys, mapping, opts)
  vim.keymap.set('', keys, mapping, opts)
end

return M
