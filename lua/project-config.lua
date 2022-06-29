local M = {}

local util = require 'util'

package.path = package.path .. ';' .. vim.fn.getcwd() .. '/.nvim-config/?.lua'

local function get_config(name)
  local config = nil
  if util.is_module_available(name) then
    config = require(name)
  end
  if config == nil then
    config = {}
  end
  return config
end

function M.get_lsp_config()
  return get_config 'lsp'
end

function M.get_jester_config()
  return get_config 'jester'
end

return M
