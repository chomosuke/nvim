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

---@class Autocmd
---@field event string[]|string
---@field opts AutocmdOpts

---create autocmds
---@param name string
---@param autocmds Autocmd[]
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

-- mapping --

local function keymap(mode, keys, mapping, options)
  local opts = { noremap = true }
  if options ~= nil then
    for key, value in pairs(options) do
      opts[key] = value
    end
  end
  vim.keymap.set(mode, keys, mapping, opts)
end

-- for all modes
function M.amap(keys, mapping, opts)
  keymap('', keys, mapping, opts)
  keymap('!', keys, mapping, opts)
  keymap('t', keys, mapping, opts)
end

function M.cmap(keys, mapping, opts)
  keymap('c', keys, mapping, opts)
end

function M.tmap(keys, mapping, opts)
  keymap('t', keys, mapping, opts)
end

function M.imap(keys, mapping, opts)
  keymap('i', keys, mapping, opts)
end

function M.nmap(keys, mapping, opts)
  keymap('n', keys, mapping, opts)
end

function M.map(keys, mapping, opts)
  keymap('', keys, mapping, opts)
end

return M
