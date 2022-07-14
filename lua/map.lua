local M = {}

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
