local M = {}

local function keymap(mode, keys, mapping)
  vim.keymap.set(mode, keys, mapping, { noremap = true })
end

-- for all modes
function M.amap(keys, mapping)
  keymap('', keys, mapping)
  keymap('!', keys, mapping)
  keymap('t', keys, mapping)
end

function M.cmap(keys, mapping)
  keymap('c', keys, mapping)
end

function M.tmap(keys, mapping)
  keymap('t', keys, mapping)
end

function M.imap(keys, mapping)
  keymap('i', keys, mapping)
end

function M.nmap(keys, mapping)
  keymap('n', keys, mapping)
end

function M.map(keys, mapping)
  keymap('', keys, mapping)
end

return M
